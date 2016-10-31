/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the QtQml module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** As a special exception, The Qt Company gives you certain additional
** rights. These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/
#ifndef QV4VALUE_P_H
#define QV4VALUE_P_H

//
//  W A R N I N G
//  -------------
//
// This file is not part of the Qt API.  It exists purely as an
// implementation detail.  This header file may change from version to
// version without notice, or even be removed.
//
// We mean it.
//

#include <limits.h>

#include <QtCore/QString>
#include "qv4global_p.h"
#include <private/qv4heap_p.h>

#if QT_POINTER_SIZE == 8
#define QV4_USE_64_BIT_VALUE_ENCODING
#endif

QT_BEGIN_NAMESPACE

namespace QV4 {

namespace Heap {
    struct Base;
}

typedef uint Bool;

struct Q_QML_PRIVATE_EXPORT Value
{
    /*
        We use two different ways of encoding JS values. One for 32bit and one for 64bit systems.

        In both cases, we use 8 bytes for a value and a different variant of NaN boxing. A Double NaN (actually -qNaN)
        is indicated by a number that has the top 13 bits set. The other values are usually set to 0 by the
        processor, and are thus free for us to store other data. We keep pointers in there for managed objects,
        and encode the other types using the free space given to use by the unused bits for NaN values. This also
        works for pointers on 64 bit systems, as they all currently only have 48 bits of addressable memory.

        On 32bit, we store doubles as doubles. All other values, have the high 32bits set to a value that
        will make the number a NaN. The Masks below are used for encoding the other types.

        On 64 bit, we xor Doubles with (0xffff8000 << 32). That has the effect that no doubles will get encoded
        with the 13 highest bits all 0. We are now using special values for bits 14-17 to encode our values. These
        can be used, as the highest valid pointer on a 64 bit system is 2^48-1.

        If they are all 0, we have a pointer to a Managed object. If bit 14 is set we have an integer.
        This makes testing for pointers and numbers very fast (we have a number if any of the highest 14 bits is set).

        Bit 15-17 is then used to encode other immediates.
    */

    quint64 _val;

    Q_ALWAYS_INLINE quint64 val() const { return _val; }
    Q_ALWAYS_INLINE void setVal(quint64 v) { _val = v; }
    Q_ALWAYS_INLINE void setValue(quint32 v) { memcpy(&_val, &v, 4); }
    Q_ALWAYS_INLINE void setTag(quint32 t) { memcpy(4 + (quint8 *)&_val, &t, 4); }

#if Q_BYTE_ORDER == Q_LITTLE_ENDIAN
    static inline int valueOffset() { return 0; }
    static inline int tagOffset() { return 4; }
    Q_ALWAYS_INLINE void setTagValue(quint32 tag, quint32 value) { _val = quint64(tag) << 32 | value; }
    Q_ALWAYS_INLINE quint32 value() const { return _val & quint64(~quint32(0)); }
    Q_ALWAYS_INLINE quint32 tag() const { return _val >> 32; }
#else // !Q_LITTLE_ENDIAN
    static inline int valueOffset() { return 4; }
    static inline int tagOffset() { return 0; }
    Q_ALWAYS_INLINE void setTagValue(quint32 tag, quint32 value) { _val = quint64(value) << 32 | tag; }
    Q_ALWAYS_INLINE quint32 tag() const { return _val & quint64(~quint32(0)); }
    Q_ALWAYS_INLINE quint32 value() const { return _val >> 32; }
#endif

#if defined(V4_BOOTSTRAP)
    Q_ALWAYS_INLINE Heap::Base *m() const { Q_UNREACHABLE(); return Q_NULLPTR; }
    Q_ALWAYS_INLINE void setM(Heap::Base *b) { Q_UNUSED(b); Q_UNREACHABLE(); }
#elif defined(QV4_USE_64_BIT_VALUE_ENCODING)
    Q_ALWAYS_INLINE Heap::Base *m() const { Heap::Base *b; memcpy(&b, &_val, 8); return b; }
    Q_ALWAYS_INLINE void setM(Heap::Base *b) { memcpy(&_val, &b, 8); }
#else // !QV4_USE_64_BIT_VALUE_ENCODING
    Q_ALWAYS_INLINE Heap::Base *m() const { Q_STATIC_ASSERT(sizeof(Heap::Base*) == sizeof(quint32)); Heap::Base *b; quint32 v = value(); memcpy(&b, &v, 4); return b; }
    Q_ALWAYS_INLINE void setM(Heap::Base *b) { quint32 v; memcpy(&v, &b, 4); setValue(v); }
#endif

    Q_ALWAYS_INLINE int int_32() const { int i; quint32 v = value(); memcpy(&i, &v, 4); return i; }
    Q_ALWAYS_INLINE void setInt_32(int i) { quint32 u; memcpy(&u, &i, 4); setValue(u); }
    Q_ALWAYS_INLINE uint uint_32() const { return value(); }

#ifndef QV4_USE_64_BIT_VALUE_ENCODING
    enum Masks {
        SilentNaNBit           =                  0x00040000,
        NaN_Mask               =                  0x7ff80000,
        NotDouble_Mask         =                  0x7ffa0000,
        Type_Mask              =                  0xffffc000,
        Immediate_Mask         = NotDouble_Mask | 0x00004000 | SilentNaNBit,
        IsNullOrUndefined_Mask = Immediate_Mask |    0x08000,
        Tag_Shift = 32
    };
    enum ValueType {
        Undefined_Type = Immediate_Mask | 0x00000,
        Null_Type      = Immediate_Mask | 0x10000,
        Boolean_Type   = Immediate_Mask | 0x08000,
        Integer_Type   = Immediate_Mask | 0x18000,
        Managed_Type   = NotDouble_Mask | 0x00000 | SilentNaNBit,
        Empty_Type     = NotDouble_Mask | 0x18000 | SilentNaNBit
    };

    enum ImmediateFlags {
        ConvertibleToInt = Immediate_Mask | 0x1
    };

    enum ValueTypeInternal {
        Null_Type_Internal = Null_Type | ConvertibleToInt,
        Boolean_Type_Internal = Boolean_Type | ConvertibleToInt,
        Integer_Type_Internal = Integer_Type | ConvertibleToInt,

    };
#else
    static const quint64 NaNEncodeMask = 0xffff800000000000ll;
    static const quint64 IsInt32Mask  = 0x0002000000000000ll;
    static const quint64 IsDoubleMask = 0xfffc000000000000ll;
    static const quint64 IsNumberMask = IsInt32Mask|IsDoubleMask;
    static const quint64 IsNullOrUndefinedMask = 0x0000800000000000ll;
    static const quint64 IsNullOrBooleanMask = 0x0001000000000000ll;
    static const quint64 IsConvertibleToIntMask = IsInt32Mask|IsNullOrBooleanMask;

    enum Masks {
        NaN_Mask = 0x7ff80000,
        Type_Mask = 0xffff8000,
        IsDouble_Mask = 0xfffc0000,
        Immediate_Mask = 0x00018000,
        IsNullOrUndefined_Mask = 0x00008000,
        IsNullOrBoolean_Mask = 0x00010000,
        Tag_Shift = 32
    };
    enum ValueType {
        Undefined_Type = IsNullOrUndefined_Mask,
        Null_Type = IsNullOrUndefined_Mask|IsNullOrBoolean_Mask,
        Boolean_Type = IsNullOrBoolean_Mask,
        Integer_Type = 0x20000|IsNullOrBoolean_Mask,
        Managed_Type = 0,
        Empty_Type = Undefined_Type | 0x4000
    };
    enum {
        IsDouble_Shift = 64-14,
        IsNumber_Shift = 64-15,
        IsConvertibleToInt_Shift = 64-16,
        IsManaged_Shift = 64-17
    };


    enum ValueTypeInternal {
        Null_Type_Internal = Null_Type,
        Boolean_Type_Internal = Boolean_Type,
        Integer_Type_Internal = Integer_Type
    };
#endif

    inline unsigned type() const {
        return tag() & Type_Mask;
    }

    // used internally in property
    inline bool isEmpty() const { return tag() == Empty_Type; }

    inline bool isUndefined() const { return tag() == Undefined_Type; }
    inline bool isNull() const { return tag() == Null_Type_Internal; }
    inline bool isBoolean() const { return tag ()== Boolean_Type_Internal; }
#ifdef QV4_USE_64_BIT_VALUE_ENCODING
    inline bool isInteger() const { return (_val >> IsNumber_Shift) == 1; }
    inline bool isDouble() const { return (_val >> IsDouble_Shift); }
    inline bool isNumber() const { return (_val >> IsNumber_Shift); }
    inline bool isManaged() const { return !(_val >> IsManaged_Shift); }
    inline bool isNullOrUndefined() const { return ((_val >> IsManaged_Shift) & ~2) == 1; }
    inline bool integerCompatible() const { return ((_val >> IsConvertibleToInt_Shift) & ~2) == 1; }
    static inline bool integerCompatible(Value a, Value b) {
        return a.integerCompatible() && b.integerCompatible();
    }
    static inline bool bothDouble(Value a, Value b) {
        return a.isDouble() && b.isDouble();
    }
    inline bool isNaN() const { return (tag() & 0x7fff8000) == 0x00078000; }
#else
    inline bool isInteger() const { return tag() == Integer_Type_Internal; }
    inline bool isDouble() const { return (tag() & NotDouble_Mask) != NotDouble_Mask; }
    inline bool isNumber() const { return tag() == Integer_Type_Internal || (tag() & NotDouble_Mask) != NotDouble_Mask; }
    inline bool isManaged() const { return tag() == Managed_Type; }
    inline bool isNullOrUndefined() const { return (tag() & IsNullOrUndefined_Mask) == Undefined_Type; }
    inline bool integerCompatible() const { return (tag() & ConvertibleToInt) == ConvertibleToInt; }
    static inline bool integerCompatible(Value a, Value b) {
        return ((a.tag() & b.tag()) & ConvertibleToInt) == ConvertibleToInt;
    }
    static inline bool bothDouble(Value a, Value b) {
        return ((a.tag() | b.tag()) & NotDouble_Mask) != NotDouble_Mask;
    }
    inline bool isNaN() const { return (tag() & QV4::Value::NotDouble_Mask) == QV4::Value::NaN_Mask; }
#endif
    Q_ALWAYS_INLINE double doubleValue() const {
        Q_ASSERT(isDouble());
        double d;
        quint64 v = _val;
#ifdef QV4_USE_64_BIT_VALUE_ENCODING
        v ^= NaNEncodeMask;
#endif
        memcpy(&d, &v, 8);
        return d;
    }
    Q_ALWAYS_INLINE void setDouble(double d) {
        memcpy(&_val, &d, 8);
#ifdef QV4_USE_64_BIT_VALUE_ENCODING
        _val ^= NaNEncodeMask;
#endif
        Q_ASSERT(isDouble());
    }
    inline bool isString() const;
    inline bool isObject() const;
    inline bool isInt32() {
        if (tag() == Integer_Type_Internal)
            return true;
        if (isDouble()) {
            double d = doubleValue();
            int i = (int)d;
            if (i == d) {
                setInt_32(i);
                setTag(Integer_Type_Internal);
                return true;
            }
        }
        return false;
    }
    double asDouble() const {
        if (tag() == Integer_Type_Internal)
            return int_32();
        return doubleValue();
    }

    bool booleanValue() const {
        return int_32();
    }
    int integerValue() const {
        return int_32();
    }

    Q_ALWAYS_INLINE String *stringValue() const {
        return m() ? reinterpret_cast<String*>(const_cast<Value *>(this)) : 0;
    }
    Q_ALWAYS_INLINE Object *objectValue() const {
        return m() ? reinterpret_cast<Object*>(const_cast<Value *>(this)) : 0;
    }
    Q_ALWAYS_INLINE Managed *managed() const {
        return m() ? reinterpret_cast<Managed*>(const_cast<Value *>(this)) : 0;
    }
    Q_ALWAYS_INLINE Heap::Base *heapObject() const {
        return m();
    }

    Q_ALWAYS_INLINE quint64 &rawValueRef() {
        return _val;
    }
    Q_ALWAYS_INLINE quint64 rawValue() const {
        return _val;
    }
    Q_ALWAYS_INLINE void setRawValue(quint64 raw) { _val = raw; }

    static inline Value fromHeapObject(Heap::Base *m)
    {
        Value v;
        v.setRawValue(0);
        v.setM(m);
#ifndef QV4_USE_64_BIT_VALUE_ENCODING
        v.setTag(Managed_Type);
#endif
        return v;
    }

    int toUInt16() const;
    inline int toInt32() const;
    inline unsigned int toUInt32() const;

    bool toBoolean() const;
    double toInteger() const;
    inline double toNumber() const;
    double toNumberImpl() const;
    QString toQStringNoThrow() const;
    QString toQString() const;
    Heap::String *toString(ExecutionEngine *e) const;
    Heap::Object *toObject(ExecutionEngine *e) const;

    inline bool isPrimitive() const;
    inline bool tryIntegerConversion() {
        bool b = integerCompatible();
        if (b)
            setTag(Integer_Type_Internal);
        return b;
    }

    template <typename T>
    const T *as() const {
        if (!m() || !isManaged())
            return 0;

        Q_ASSERT(m()->vtable());
#if !defined(QT_NO_QOBJECT_CHECK)
        static_cast<const T *>(this)->qt_check_for_QMANAGED_macro(static_cast<const T *>(this));
#endif
        const VTable *vt = m()->vtable();
        while (vt) {
            if (vt == T::staticVTable())
                return static_cast<const T *>(this);
            vt = vt->parent;
        }
        return 0;
    }
    template <typename T>
    T *as() {
        return const_cast<T *>(const_cast<const Value *>(this)->as<T>());
    }

    template<typename T> inline T *cast() {
        return static_cast<T *>(managed());
    }
    template<typename T> inline const T *cast() const {
        return static_cast<const T *>(managed());
    }

    inline uint asArrayIndex() const;
#ifndef V4_BOOTSTRAP
    uint asArrayLength(bool *ok) const;
#endif

    ReturnedValue asReturnedValue() const { return _val; }
    static Value fromReturnedValue(ReturnedValue val) { Value v; v._val = val; return v; }

    // Section 9.12
    bool sameValue(Value other) const;

    inline void mark(ExecutionEngine *e);

    Value &operator =(const ScopedValue &v);
    Value &operator=(ReturnedValue v) { _val = v; return *this; }
    Value &operator=(Managed *m) {
        if (!m) {
            setTagValue(Undefined_Type, 0);
        } else {
            _val = reinterpret_cast<Value *>(m)->_val;
        }
        return *this;
    }
    Value &operator=(Heap::Base *o) {
        setM(o);
#ifndef QV4_USE_64_BIT_VALUE_ENCODING
        setTag(Managed_Type);
#endif
        return *this;
    }

    template<typename T>
    Value &operator=(const Scoped<T> &t);
    Value &operator=(const Value &v) {
        _val = v._val;
        return *this;
    }
};

inline bool Value::isString() const
{
    if (!isManaged())
        return false;
    return m() && m()->vtable()->isString;
}
inline bool Value::isObject() const
{
    if (!isManaged())
        return false;
    return m() && m()->vtable()->isObject;
}

inline bool Value::isPrimitive() const
{
    return !isObject();
}

inline double Value::toNumber() const
{
    if (isInteger())
        return int_32();
    if (isDouble())
        return doubleValue();
    return toNumberImpl();
}


#ifndef V4_BOOTSTRAP
inline uint Value::asArrayIndex() const
{
#ifdef QV4_USE_64_BIT_VALUE_ENCODING
    if (!isNumber())
        return UINT_MAX;
    if (isInteger())
        return int_32() >= 0 ? (uint)int_32() : UINT_MAX;
#else
    if (isInteger() && int_32() >= 0)
        return (uint)int_32();
    if (!isDouble())
        return UINT_MAX;
#endif
    double d = doubleValue();
    uint idx = (uint)d;
    if (idx != d)
        return UINT_MAX;
    return idx;
}
#endif

inline
ReturnedValue Heap::Base::asReturnedValue() const
{
    return Value::fromHeapObject(const_cast<Heap::Base *>(this)).asReturnedValue();
}



struct Q_QML_PRIVATE_EXPORT Primitive : public Value
{
    inline static Primitive emptyValue();
    static inline Primitive fromBoolean(bool b);
    static inline Primitive fromInt32(int i);
    inline static Primitive undefinedValue();
    static inline Primitive nullValue();
    static inline Primitive fromDouble(double d);
    static inline Primitive fromUInt32(uint i);

    using Value::toInt32;
    using Value::toUInt32;

    static double toInteger(double fromNumber);
    static int toInt32(double value);
    static unsigned int toUInt32(double value);
};

inline Primitive Primitive::undefinedValue()
{
    Primitive v;
#ifdef QV4_USE_64_BIT_VALUE_ENCODING
    v.setRawValue(quint64(Undefined_Type) << Tag_Shift);
#else
    v.setRawValue(0);
    v.setTag(Undefined_Type);
    v.setValue(0);
#endif
    return v;
}

inline Primitive Primitive::emptyValue()
{
    Primitive v;
    v.setTagValue(Value::Empty_Type, 0);
    return v;
}

inline Primitive Primitive::nullValue()
{
    Primitive v;
#ifndef QV4_USE_64_BIT_VALUE_ENCODING
    v.setRawValue(quint64(Null_Type_Internal) << Tag_Shift);
#else
    v.setTagValue(Null_Type_Internal, 0);
#endif
    return v;
}

inline Primitive Primitive::fromBoolean(bool b)
{
    Primitive v;
    v.setTagValue(Boolean_Type_Internal, b);
    return v;
}

inline Primitive Primitive::fromDouble(double d)
{
    Primitive v;
    v.setDouble(d);
    return v;
}

inline Primitive Primitive::fromInt32(int i)
{
    Primitive v;
    v.setTagValue(Integer_Type_Internal, 0); // For mingw482, because it complains, and for VS9, because of internal compiler errors.
    v.setInt_32(i);
    return v;
}

inline Primitive Primitive::fromUInt32(uint i)
{
    Primitive v;
    if (i < INT_MAX) {
        v.setTagValue(Integer_Type_Internal, 0); // For mingw482, because it complains, and for VS9, because of internal compiler errors.
        v.setInt_32((int)i);
    } else {
        v.setDouble(i);
    }
    return v;
}

struct Encode {
    static ReturnedValue undefined() {
        return quint64(Value::Undefined_Type) << Value::Tag_Shift;
    }
    static ReturnedValue null() {
        return quint64(Value::Null_Type_Internal) << Value::Tag_Shift;
    }

    Encode(bool b) {
        val = (quint64(Value::Boolean_Type_Internal) << Value::Tag_Shift) | (uint)b;
    }
    Encode(double d) {
        Value v;
        v.setDouble(d);
        val = v.rawValue();
    }
    Encode(int i) {
        val = (quint64(Value::Integer_Type_Internal) << Value::Tag_Shift) | (uint)i;
    }
    Encode(uint i) {
        if (i <= INT_MAX) {
            val = (quint64(Value::Integer_Type_Internal) << Value::Tag_Shift) | i;
        } else {
            Value v;
            v.setDouble(i);
            val = v.rawValue();
        }
    }
    Encode(ReturnedValue v) {
        val = v;
    }

    Encode(Heap::Base *o) {
        Q_ASSERT(o);
        val = Value::fromHeapObject(o).asReturnedValue();
    }

    operator ReturnedValue() const {
        return val;
    }
    quint64 val;
private:
    Encode(void *);
};

template<typename T>
ReturnedValue value_convert(ExecutionEngine *e, const Value &v);

inline int Value::toInt32() const
{
    if (isInteger())
        return int_32();
    double d = isNumber() ? doubleValue() : toNumberImpl();

    const double D32 = 4294967296.0;
    const double D31 = D32 / 2.0;

    if ((d >= -D31 && d < D31))
        return static_cast<int>(d);

    return Primitive::toInt32(d);
}

inline unsigned int Value::toUInt32() const
{
    return (unsigned int)toInt32();
}


}

QT_END_NAMESPACE

#endif // QV4VALUE_DEF_P_H
