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
#ifndef QV4ENGINE_H
#define QV4ENGINE_H

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

#include "qv4global_p.h"
#include "private/qv4isel_p.h"
#include "qv4managed_p.h"
#include "qv4context_p.h"
#include "qv4internalclass_p.h"
#include <private/qintrusivelist_p.h>

namespace WTF {
class BumpPointerAllocator;
class PageAllocation;
}

QT_BEGIN_NAMESPACE

class QV8Engine;
class QQmlError;
class QJSEngine;
class QQmlEngine;
class QQmlContextData;

namespace QV4 {
namespace Debugging {
class Debugger;
} // namespace Debugging
namespace Profiling {
class Profiler;
} // namespace Profiling
namespace CompiledData {
struct CompilationUnit;
}

struct Q_QML_EXPORT ExecutionEngine
{
private:
    static qint32 maxCallDepth;

    friend struct ExecutionContextSaver;
    friend struct ExecutionContext;
    friend struct Heap::ExecutionContext;
public:
    Heap::ExecutionContext *current;

    Value *jsStackTop;
    quint32 hasException;
    qint32 callDepth;

    MemoryManager *memoryManager;
    ExecutableAllocator *executableAllocator;
    ExecutableAllocator *regExpAllocator;
    QScopedPointer<EvalISelFactory> iselFactory;

    ExecutionContext *currentContext;

    Value *jsStackLimit;

    WTF::BumpPointerAllocator *bumperPointerAllocator; // Used by Yarr Regex engine.

    enum { JSStackLimit = 4*1024*1024 };
    WTF::PageAllocation *jsStack;
    Value *jsStackBase;

    void pushForGC(Heap::Base *m) {
        *jsStackTop = m;
        ++jsStackTop;
    }
    Heap::Base *popForGC() {
        --jsStackTop;
        return jsStackTop->heapObject();
    }
    Value *jsAlloca(int nValues) {
        Value *ptr = jsStackTop;
        jsStackTop = ptr + nValues;
        memset(ptr, 0, nValues*sizeof(Value));
        return ptr;
    }

    IdentifierTable *identifierTable;

    QV4::Debugging::Debugger *debugger;
    QV4::Profiling::Profiler *profiler;

    Object *globalObject;

    Function *globalCode;

    QJSEngine *jsEngine() const;
    QQmlEngine *qmlEngine() const;
    QV8Engine *v8Engine;

    enum JSObjects {
        RootContext,
        IntegerNull, // Has to come after the RootContext to make the context stack safe
        ObjectProto,
        ArrayProto,
        StringProto,
        NumberProto,
        BooleanProto,
        DateProto,
        FunctionProto,
        RegExpProto,
        ErrorProto,
        EvalErrorProto,
        RangeErrorProto,
        ReferenceErrorProto,
        SyntaxErrorProto,
        TypeErrorProto,
        URIErrorProto,
        VariantProto,
        SequenceProto,
        ArrayBufferProto,
        DataViewProto,
        ValueTypeProto,
        SignalHandlerProto,

        Object_Ctor,
        String_Ctor,
        Number_Ctor,
        Boolean_Ctor,
        Array_Ctor,
        Function_Ctor,
        Date_Ctor,
        RegExp_Ctor,
        Error_Ctor,
        EvalError_Ctor,
        RangeError_Ctor,
        ReferenceError_Ctor,
        SyntaxError_Ctor,
        TypeError_Ctor,
        URIError_Ctor,
        ArrayBuffer_Ctor,
        DataView_Ctor,

        Eval_Function,
        GetStack_Function,
        ThrowerObject,
        NJSObjects
    };
    Value *jsObjects;
    enum { NTypedArrayTypes = 9 }; // == TypedArray::NValues, avoid header dependency

    GlobalContext *rootContext() const { return reinterpret_cast<GlobalContext *>(jsObjects + RootContext); }
    FunctionObject *objectCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Object_Ctor); }
    FunctionObject *stringCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + String_Ctor); }
    FunctionObject *numberCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Number_Ctor); }
    FunctionObject *booleanCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Boolean_Ctor); }
    FunctionObject *arrayCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Array_Ctor); }
    FunctionObject *functionCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Function_Ctor); }
    FunctionObject *dateCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Date_Ctor); }
    FunctionObject *regExpCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + RegExp_Ctor); }
    FunctionObject *errorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + Error_Ctor); }
    FunctionObject *evalErrorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + EvalError_Ctor); }
    FunctionObject *rangeErrorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + RangeError_Ctor); }
    FunctionObject *referenceErrorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + ReferenceError_Ctor); }
    FunctionObject *syntaxErrorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + SyntaxError_Ctor); }
    FunctionObject *typeErrorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + TypeError_Ctor); }
    FunctionObject *uRIErrorCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + URIError_Ctor); }
    FunctionObject *arrayBufferCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + ArrayBuffer_Ctor); }
    FunctionObject *dataViewCtor() const { return reinterpret_cast<FunctionObject *>(jsObjects + DataView_Ctor); }
    FunctionObject *typedArrayCtors;

    Object *objectPrototype() const { return reinterpret_cast<Object *>(jsObjects + ObjectProto); }
    Object *arrayPrototype() const { return reinterpret_cast<Object *>(jsObjects + ArrayProto); }
    Object *stringPrototype() const { return reinterpret_cast<Object *>(jsObjects + StringProto); }
    Object *numberPrototype() const { return reinterpret_cast<Object *>(jsObjects + NumberProto); }
    Object *booleanPrototype() const { return reinterpret_cast<Object *>(jsObjects + BooleanProto); }
    Object *datePrototype() const { return reinterpret_cast<Object *>(jsObjects + DateProto); }
    Object *functionPrototype() const { return reinterpret_cast<Object *>(jsObjects + FunctionProto); }
    Object *regExpPrototype() const { return reinterpret_cast<Object *>(jsObjects + RegExpProto); }
    Object *errorPrototype() const { return reinterpret_cast<Object *>(jsObjects + ErrorProto); }
    Object *evalErrorPrototype() const { return reinterpret_cast<Object *>(jsObjects + EvalErrorProto); }
    Object *rangeErrorPrototype() const { return reinterpret_cast<Object *>(jsObjects + RangeErrorProto); }
    Object *referenceErrorPrototype() const { return reinterpret_cast<Object *>(jsObjects + ReferenceErrorProto); }
    Object *syntaxErrorPrototype() const { return reinterpret_cast<Object *>(jsObjects + SyntaxErrorProto); }
    Object *typeErrorPrototype() const { return reinterpret_cast<Object *>(jsObjects + TypeErrorProto); }
    Object *uRIErrorPrototype() const { return reinterpret_cast<Object *>(jsObjects + URIErrorProto); }
    Object *variantPrototype() const { return reinterpret_cast<Object *>(jsObjects + VariantProto); }
    Object *sequencePrototype() const { return reinterpret_cast<Object *>(jsObjects + SequenceProto); }

    Object *arrayBufferPrototype() const { return reinterpret_cast<Object *>(jsObjects + ArrayBufferProto); }
    Object *dataViewPrototype() const { return reinterpret_cast<Object *>(jsObjects + DataViewProto); }
    Object *typedArrayPrototype;

    Object *valueTypeWrapperPrototype() const { return reinterpret_cast<Object *>(jsObjects + ValueTypeProto); }
    Object *signalHandlerPrototype() const { return reinterpret_cast<Object *>(jsObjects + SignalHandlerProto); }

    InternalClassPool *classPool;
    InternalClass *emptyClass;

    InternalClass *arrayClass;
    InternalClass *stringClass;

    InternalClass *functionClass;
    InternalClass *simpleScriptFunctionClass;
    InternalClass *protoClass;

    InternalClass *regExpExecArrayClass;
    InternalClass *regExpObjectClass;

    InternalClass *argumentsObjectClass;
    InternalClass *strictArgumentsObjectClass;

    InternalClass *errorClass;
    InternalClass *errorClassWithMessage;
    InternalClass *errorProtoClass;

    EvalFunction *evalFunction() const { return reinterpret_cast<EvalFunction *>(jsObjects + Eval_Function); }
    FunctionObject *getStackFunction() const { return reinterpret_cast<FunctionObject *>(jsObjects + GetStack_Function); }
    FunctionObject *thrower() const { return reinterpret_cast<FunctionObject *>(jsObjects + ThrowerObject); }

    Property *argumentsAccessors;
    int nArgumentsAccessors;

    enum JSStrings {
        String_Empty,
        String_undefined,
        String_null,
        String_true,
        String_false,
        String_boolean,
        String_number,
        String_string,
        String_object,
        String_function,
        String_length,
        String_prototype,
        String_constructor,
        String_arguments,
        String_caller,
        String_callee,
        String_this,
        String___proto__,
        String_enumerable,
        String_configurable,
        String_writable,
        String_value,
        String_get,
        String_set,
        String_eval,
        String_uintMax,
        String_name,
        String_index,
        String_input,
        String_toString,
        String_destroy,
        String_valueOf,
        String_byteLength,
        String_byteOffset,
        String_buffer,
        String_lastIndex,
        NJSStrings
    };
    Value *jsStrings;

    String *id_empty() const { return reinterpret_cast<String *>(jsStrings + String_Empty); }
    String *id_undefined() const { return reinterpret_cast<String *>(jsStrings + String_undefined); }
    String *id_null() const { return reinterpret_cast<String *>(jsStrings + String_null); }
    String *id_true() const { return reinterpret_cast<String *>(jsStrings + String_true); }
    String *id_false() const { return reinterpret_cast<String *>(jsStrings + String_false); }
    String *id_boolean() const { return reinterpret_cast<String *>(jsStrings + String_boolean); }
    String *id_number() const { return reinterpret_cast<String *>(jsStrings + String_number); }
    String *id_string() const { return reinterpret_cast<String *>(jsStrings + String_string); }
    String *id_object() const { return reinterpret_cast<String *>(jsStrings + String_object); }
    String *id_function() const { return reinterpret_cast<String *>(jsStrings + String_function); }
    String *id_length() const { return reinterpret_cast<String *>(jsStrings + String_length); }
    String *id_prototype() const { return reinterpret_cast<String *>(jsStrings + String_prototype); }
    String *id_constructor() const { return reinterpret_cast<String *>(jsStrings + String_constructor); }
    String *id_arguments() const { return reinterpret_cast<String *>(jsStrings + String_arguments); }
    String *id_caller() const { return reinterpret_cast<String *>(jsStrings + String_caller); }
    String *id_callee() const { return reinterpret_cast<String *>(jsStrings + String_callee); }
    String *id_this() const { return reinterpret_cast<String *>(jsStrings + String_this); }
    String *id___proto__() const { return reinterpret_cast<String *>(jsStrings + String___proto__); }
    String *id_enumerable() const { return reinterpret_cast<String *>(jsStrings + String_enumerable); }
    String *id_configurable() const { return reinterpret_cast<String *>(jsStrings + String_configurable); }
    String *id_writable() const { return reinterpret_cast<String *>(jsStrings + String_writable); }
    String *id_value() const { return reinterpret_cast<String *>(jsStrings + String_value); }
    String *id_get() const { return reinterpret_cast<String *>(jsStrings + String_get); }
    String *id_set() const { return reinterpret_cast<String *>(jsStrings + String_set); }
    String *id_eval() const { return reinterpret_cast<String *>(jsStrings + String_eval); }
    String *id_uintMax() const { return reinterpret_cast<String *>(jsStrings + String_uintMax); }
    String *id_name() const { return reinterpret_cast<String *>(jsStrings + String_name); }
    String *id_index() const { return reinterpret_cast<String *>(jsStrings + String_index); }
    String *id_input() const { return reinterpret_cast<String *>(jsStrings + String_input); }
    String *id_toString() const { return reinterpret_cast<String *>(jsStrings + String_toString); }
    String *id_destroy() const { return reinterpret_cast<String *>(jsStrings + String_destroy); }
    String *id_valueOf() const { return reinterpret_cast<String *>(jsStrings + String_valueOf); }
    String *id_byteLength() const { return reinterpret_cast<String *>(jsStrings + String_byteLength); }
    String *id_byteOffset() const { return reinterpret_cast<String *>(jsStrings + String_byteOffset); }
    String *id_buffer() const { return reinterpret_cast<String *>(jsStrings + String_buffer); }
    String *id_lastIndex() const { return reinterpret_cast<String *>(jsStrings + String_lastIndex); }

    QSet<CompiledData::CompilationUnit*> compilationUnits;

    quint32 m_engineId;

    RegExpCache *regExpCache;

    // Scarce resources are "exceptionally high cost" QVariant types where allowing the
    // normal JavaScript GC to clean them up is likely to lead to out-of-memory or other
    // out-of-resource situations.  When such a resource is passed into JavaScript we
    // add it to the scarceResources list and it is destroyed when we return from the
    // JavaScript execution that created it.  The user can prevent this behavior by
    // calling preserve() on the object which removes it from this scarceResource list.
    class ScarceResourceData {
    public:
        ScarceResourceData(const QVariant &data = QVariant()) : data(data) {}
        QVariant data;
        QIntrusiveListNode node;
    };
    QIntrusiveList<ScarceResourceData, &ScarceResourceData::node> scarceResources;

    // Normally the JS wrappers for QObjects are stored in the QQmlData/QObjectPrivate,
    // but any time a QObject is wrapped a second time in another engine, we have to do
    // bookkeeping.
    MultiplyWrappedQObjectMap *m_multiplyWrappedQObjects;

    ExecutionEngine(EvalISelFactory *iselFactory = 0);
    ~ExecutionEngine();

    void setDebugger(Debugging::Debugger *debugger);
    void enableProfiler();

    ExecutionContext *pushGlobalContext();
    void pushContext(Heap::ExecutionContext *context);
    void pushContext(ExecutionContext *context);
    void popContext();
    ExecutionContext *parentContext(ExecutionContext *context) const;

    Heap::Object *newObject();
    Heap::Object *newObject(InternalClass *internalClass, Object *prototype);

    Heap::String *newString(const QString &s = QString());
    Heap::String *newIdentifier(const QString &text);

    Heap::Object *newStringObject(const String *string);
    Heap::Object *newNumberObject(double value);
    Heap::Object *newBooleanObject(bool b);

    Heap::ArrayObject *newArrayObject(int count = 0);
    Heap::ArrayObject *newArrayObject(const Value *values, int length);
    Heap::ArrayObject *newArrayObject(const QStringList &list);
    Heap::ArrayObject *newArrayObject(InternalClass *ic, Object *prototype);

    Heap::ArrayBuffer *newArrayBuffer(const QByteArray &array);
    Heap::ArrayBuffer *newArrayBuffer(size_t length);

    Heap::DateObject *newDateObject(const Value &value);
    Heap::DateObject *newDateObject(const QDateTime &dt);

    Heap::RegExpObject *newRegExpObject(const QString &pattern, int flags);
    Heap::RegExpObject *newRegExpObject(RegExp *re, bool global);
    Heap::RegExpObject *newRegExpObject(const QRegExp &re);

    Heap::Object *newErrorObject(const Value &value);
    Heap::Object *newSyntaxErrorObject(const QString &message, const QString &fileName, int line, int column);
    Heap::Object *newSyntaxErrorObject(const QString &message);
    Heap::Object *newReferenceErrorObject(const QString &message);
    Heap::Object *newReferenceErrorObject(const QString &message, const QString &fileName, int line, int column);
    Heap::Object *newTypeErrorObject(const QString &message);
    Heap::Object *newRangeErrorObject(const QString &message);
    Heap::Object *newURIErrorObject(const Value &message);

    Heap::Object *newVariantObject(const QVariant &v);

    Heap::Object *newForEachIteratorObject(Object *o);

    Heap::QmlContext *qmlContext() const;
    QObject *qmlScopeObject() const;
    ReturnedValue qmlSingletonWrapper(String *name);
    QQmlContextData *callingQmlContext() const;


    StackTrace stackTrace(int frameLimit = -1) const;
    StackFrame currentStackFrame() const;
    QUrl resolvedUrl(const QString &file);

    void requireArgumentsAccessors(int n);

    void markObjects();

    void initRootContext();

    InternalClass *newClass(const InternalClass &other);

    // Exception handling
    Value *exceptionValue;
    StackTrace exceptionStackTrace;

    ReturnedValue throwError(const Value &value);
    ReturnedValue catchException(StackTrace *trace = 0);

    ReturnedValue throwError(const QString &message);
    ReturnedValue throwSyntaxError(const QString &message);
    ReturnedValue throwSyntaxError(const QString &message, const QString &fileName, int lineNumber, int column);
    ReturnedValue throwTypeError();
    ReturnedValue throwTypeError(const QString &message);
    ReturnedValue throwReferenceError(const Value &value);
    ReturnedValue throwReferenceError(const QString &value, const QString &fileName, int lineNumber, int column);
    ReturnedValue throwRangeError(const Value &value);
    ReturnedValue throwRangeError(const QString &message);
    ReturnedValue throwURIError(const Value &msg);
    ReturnedValue throwUnimplemented(const QString &message);

    // Use only inside catch(...) -- will re-throw if no JS exception
    QQmlError catchExceptionAsQmlError();

    // variant conversions
    QVariant toVariant(const QV4::Value &value, int typeHint, bool createJSValueForObjects = true);
    QV4::ReturnedValue fromVariant(const QVariant &);

    QVariantMap variantMapFromJS(const QV4::Object *o);

    bool metaTypeFromJS(const Value *value, int type, void *data);
    QV4::ReturnedValue metaTypeToJS(int type, const void *data);

    void assertObjectBelongsToEngine(const Heap::Base &baseObject);

    bool checkStackLimits(ReturnedValue &exception);
};

inline void ExecutionEngine::pushContext(Heap::ExecutionContext *context)
{
    Q_ASSERT(currentContext && context);
    Value *v = jsAlloca(2);
    v[0] = Encode(context);
    v[1] = Encode((int)(v - static_cast<Value *>(currentContext)));
    currentContext = static_cast<ExecutionContext *>(v);
    current = currentContext->d();
}

inline void ExecutionEngine::pushContext(ExecutionContext *context)
{
    pushContext(context->d());
}


inline void ExecutionEngine::popContext()
{
    Q_ASSERT(jsStackTop > currentContext);
    QV4::Value *offset = (currentContext + 1);
    Q_ASSERT(offset->isInteger());
    int o = offset->integerValue();
    Q_ASSERT(o);
    currentContext -= o;
    current = currentContext->d();
}

inline
void Heap::Base::mark(QV4::ExecutionEngine *engine)
{
    Q_ASSERT(inUse());
    if (isMarked())
        return;
#ifndef QT_NO_DEBUG
    engine->assertObjectBelongsToEngine(*this);
#endif
    setMarkBit();
    engine->pushForGC(this);
}

inline void Value::mark(ExecutionEngine *e)
{
    if (!isManaged())
        return;

    Heap::Base *o = heapObject();
    if (o)
        o->mark(e);
}

#define CHECK_STACK_LIMITS(v4) { ReturnedValue e; if ((v4)->checkStackLimits(e)) return e; } \
    ExecutionEngineCallDepthRecorder _executionEngineCallDepthRecorder(v4);

struct ExecutionEngineCallDepthRecorder
{
    ExecutionEngine *ee;

    ExecutionEngineCallDepthRecorder(ExecutionEngine *e): ee(e) { ++ee->callDepth; }
    ~ExecutionEngineCallDepthRecorder() { --ee->callDepth; }
};

inline bool ExecutionEngine::checkStackLimits(ReturnedValue &exception)
{
    if (Q_UNLIKELY((jsStackTop > jsStackLimit) || (callDepth >= maxCallDepth))) {
        exception = throwRangeError(QStringLiteral("Maximum call stack size exceeded."));
        return true;
    }

    return false;
}

} // namespace QV4

QT_END_NAMESPACE

#endif // QV4ENGINE_H
