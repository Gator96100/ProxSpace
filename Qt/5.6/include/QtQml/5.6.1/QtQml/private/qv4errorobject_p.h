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
#ifndef QV4ERROROBJECT_H
#define QV4ERROROBJECT_H

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

#include "qv4object_p.h"
#include "qv4functionobject_p.h"
#include "qv4string_p.h"

QT_BEGIN_NAMESPACE

namespace QV4 {

struct SyntaxErrorObject;

namespace Heap {

struct ErrorObject : Object {
    enum ErrorType {
        Error,
        EvalError,
        RangeError,
        ReferenceError,
        SyntaxError,
        TypeError,
        URIError
    };

    ErrorObject();
    ErrorObject(const Value &message, ErrorType t = Error);
    ErrorObject(const Value &message, const QString &fileName, int line, int column, ErrorType t = Error);

    ErrorType errorType;
    StackTrace stackTrace;
    Pointer<String> stack;
};

struct EvalErrorObject : ErrorObject {
    EvalErrorObject(const Value &message);
};

struct RangeErrorObject : ErrorObject {
    RangeErrorObject(const Value &message);
};

struct ReferenceErrorObject : ErrorObject {
    ReferenceErrorObject(const Value &message);
    ReferenceErrorObject(const Value &msg, const QString &fileName, int lineNumber, int columnNumber);
};

struct SyntaxErrorObject : ErrorObject {
    SyntaxErrorObject(const Value &message);
    SyntaxErrorObject(const Value &msg, const QString &fileName, int lineNumber, int columnNumber);
};

struct TypeErrorObject : ErrorObject {
    TypeErrorObject(const Value &message);
};

struct URIErrorObject : ErrorObject {
    URIErrorObject(const Value &message);
};

struct ErrorCtor : Heap::FunctionObject {
    ErrorCtor(QV4::ExecutionContext *scope);
    ErrorCtor(QV4::ExecutionContext *scope, const QString &name);
};

struct EvalErrorCtor : ErrorCtor {
    EvalErrorCtor(QV4::ExecutionContext *scope);
};

struct RangeErrorCtor : ErrorCtor {
    RangeErrorCtor(QV4::ExecutionContext *scope);
};

struct ReferenceErrorCtor : ErrorCtor {
    ReferenceErrorCtor(QV4::ExecutionContext *scope);
};

struct SyntaxErrorCtor : ErrorCtor {
    SyntaxErrorCtor(QV4::ExecutionContext *scope);
};

struct TypeErrorCtor : ErrorCtor {
    TypeErrorCtor(QV4::ExecutionContext *scope);
};

struct URIErrorCtor : ErrorCtor {
    URIErrorCtor(QV4::ExecutionContext *scope);
};

}

struct ErrorObject: Object {
    enum {
        IsErrorObject = true
    };

    enum {
        Index_Stack = 0, // Accessor Property
        Index_FileName = 2,
        Index_LineNumber = 3,
        Index_Message = 4
    };

    V4_OBJECT2(ErrorObject, Object)
    Q_MANAGED_TYPE(ErrorObject)
    V4_INTERNALCLASS(errorClass)
    V4_PROTOTYPE(errorPrototype)
    V4_NEEDS_DESTROY

    template <typename T>
    static Heap::Object *create(ExecutionEngine *e, const Value &message);
    template <typename T>
    static Heap::Object *create(ExecutionEngine *e, const QString &message);
    template <typename T>
    static Heap::Object *create(ExecutionEngine *e, const QString &message, const QString &filename, int line, int column);

    SyntaxErrorObject *asSyntaxError();

    static const char *className(Heap::ErrorObject::ErrorType t);

    static ReturnedValue method_get_stack(CallContext *ctx);
    static void markObjects(Heap::Base *that, ExecutionEngine *e);
};

template<>
inline const ErrorObject *Value::as() const {
    return isManaged() && m() && m()->vtable()->isErrorObject ? reinterpret_cast<const ErrorObject *>(this) : 0;
}

struct EvalErrorObject: ErrorObject {
    typedef Heap::EvalErrorObject Data;
    V4_PROTOTYPE(evalErrorPrototype)
    const Data *d() const { return static_cast<const Data *>(ErrorObject::d()); }
    Data *d() { return static_cast<Data *>(ErrorObject::d()); }
};

struct RangeErrorObject: ErrorObject {
    typedef Heap::RangeErrorObject Data;
    V4_PROTOTYPE(rangeErrorPrototype)
    const Data *d() const { return static_cast<const Data *>(ErrorObject::d()); }
    Data *d() { return static_cast<Data *>(ErrorObject::d()); }
};

struct ReferenceErrorObject: ErrorObject {
    typedef Heap::ReferenceErrorObject Data;
    V4_PROTOTYPE(referenceErrorPrototype)
    const Data *d() const { return static_cast<const Data *>(ErrorObject::d()); }
    Data *d() { return static_cast<Data *>(ErrorObject::d()); }
};

struct SyntaxErrorObject: ErrorObject {
    V4_OBJECT2(SyntaxErrorObject, ErrorObject)
    V4_PROTOTYPE(syntaxErrorPrototype)
};

struct TypeErrorObject: ErrorObject {
    typedef Heap::TypeErrorObject Data;
    V4_PROTOTYPE(typeErrorPrototype)
    const Data *d() const { return static_cast<const Data *>(ErrorObject::d()); }
    Data *d() { return static_cast<Data *>(ErrorObject::d()); }
};

struct URIErrorObject: ErrorObject {
    typedef Heap::URIErrorObject Data;
    V4_PROTOTYPE(uRIErrorPrototype)
    const Data *d() const { return static_cast<const Data *>(ErrorObject::d()); }
    Data *d() { return static_cast<Data *>(ErrorObject::d()); }
};

struct ErrorCtor: FunctionObject
{
    V4_OBJECT2(ErrorCtor, FunctionObject)

    static ReturnedValue construct(const Managed *, CallData *callData);
    static ReturnedValue call(const Managed *that, CallData *callData);
};

struct EvalErrorCtor: ErrorCtor
{
    V4_OBJECT2(EvalErrorCtor, ErrorCtor)

    static ReturnedValue construct(const Managed *m, CallData *callData);
};

struct RangeErrorCtor: ErrorCtor
{
    V4_OBJECT2(RangeErrorCtor, ErrorCtor)

    static ReturnedValue construct(const Managed *m, CallData *callData);
};

struct ReferenceErrorCtor: ErrorCtor
{
    V4_OBJECT2(ReferenceErrorCtor, ErrorCtor)

    static ReturnedValue construct(const Managed *m, CallData *callData);
};

struct SyntaxErrorCtor: ErrorCtor
{
    V4_OBJECT2(SyntaxErrorCtor, ErrorCtor)

    static ReturnedValue construct(const Managed *m, CallData *callData);
};

struct TypeErrorCtor: ErrorCtor
{
    V4_OBJECT2(TypeErrorCtor, ErrorCtor)

    static ReturnedValue construct(const Managed *m, CallData *callData);
};

struct URIErrorCtor: ErrorCtor
{
    V4_OBJECT2(URIErrorCtor, ErrorCtor)

    static ReturnedValue construct(const Managed *m, CallData *callData);
};


struct ErrorPrototype : ErrorObject
{
    enum {
        Index_Constructor = 0,
        Index_Message = 1,
        Index_Name = 2
    };
    void init(ExecutionEngine *engine, Object *ctor) { init(engine, ctor, this, Heap::ErrorObject::Error); }

    static void init(ExecutionEngine *engine, Object *ctor, Object *obj, Heap::ErrorObject::ErrorType t);
    static ReturnedValue method_toString(CallContext *ctx);
};

struct EvalErrorPrototype : ErrorObject
{
    void init(ExecutionEngine *engine, Object *ctor) { ErrorPrototype::init(engine, ctor, this, Heap::ErrorObject::EvalError); }
};

struct RangeErrorPrototype : ErrorObject
{
    void init(ExecutionEngine *engine, Object *ctor) { ErrorPrototype::init(engine, ctor, this, Heap::ErrorObject::RangeError); }
};

struct ReferenceErrorPrototype : ErrorObject
{
    void init(ExecutionEngine *engine, Object *ctor) { ErrorPrototype::init(engine, ctor, this, Heap::ErrorObject::ReferenceError); }
};

struct SyntaxErrorPrototype : ErrorObject
{
    void init(ExecutionEngine *engine, Object *ctor) { ErrorPrototype::init(engine, ctor, this, Heap::ErrorObject::SyntaxError); }
};

struct TypeErrorPrototype : ErrorObject
{
    void init(ExecutionEngine *engine, Object *ctor) { ErrorPrototype::init(engine, ctor, this, Heap::ErrorObject::TypeError); }
};

struct URIErrorPrototype : ErrorObject
{
    void init(ExecutionEngine *engine, Object *ctor) { ErrorPrototype::init(engine, ctor, this, Heap::ErrorObject::URIError); }
};


inline SyntaxErrorObject *ErrorObject::asSyntaxError()
{
    return d()->errorType == QV4::Heap::ErrorObject::SyntaxError ? static_cast<SyntaxErrorObject *>(this) : 0;
}


template <typename T>
Heap::Object *ErrorObject::create(ExecutionEngine *e, const Value &message) {
    return e->memoryManager->allocObject<T>(message.isUndefined() ? e->errorClass : e->errorClassWithMessage, T::defaultPrototype(e), message);
}
template <typename T>
Heap::Object *ErrorObject::create(ExecutionEngine *e, const QString &message) {
    Scope scope(e);
    ScopedValue v(scope, message.isEmpty() ? Encode::undefined() : e->newString(message)->asReturnedValue());
    return e->memoryManager->allocObject<T>(v->isUndefined() ? e->errorClass : e->errorClassWithMessage, T::defaultPrototype(e), v);
}
template <typename T>
Heap::Object *ErrorObject::create(ExecutionEngine *e, const QString &message, const QString &filename, int line, int column) {
    Scope scope(e);
    ScopedValue v(scope, message.isEmpty() ? Encode::undefined() : e->newString(message)->asReturnedValue());
    return e->memoryManager->allocObject<T>(v->isUndefined() ? e->errorClass : e->errorClassWithMessage, T::defaultPrototype(e), v, filename, line, column);
}


}

QT_END_NAMESPACE

#endif // QV4ECMAOBJECTS_P_H
