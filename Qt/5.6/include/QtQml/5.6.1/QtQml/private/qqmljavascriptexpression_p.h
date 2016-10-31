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

#ifndef QQMLJAVASCRIPTEXPRESSION_P_H
#define QQMLJAVASCRIPTEXPRESSION_P_H

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

#include <QtCore/qglobal.h>
#include <QtQml/qqmlerror.h>
#include <private/qqmlengine_p.h>
#include <private/qpointervaluepair_p.h>

QT_BEGIN_NAMESPACE

struct QQmlSourceLocation;

class QQmlDelayedError
{
public:
    inline QQmlDelayedError() : nextError(0), prevError(0) {}
    inline ~QQmlDelayedError() { removeError(); }

    bool addError(QQmlEnginePrivate *);

    inline void removeError() {
        if (!prevError) return;
        if (nextError) nextError->prevError = prevError;
        *prevError = nextError;
        nextError = 0;
        prevError = 0;
    }

    inline bool isValid() const { return m_error.isValid(); }
    inline const QQmlError &error() const { return m_error; }
    inline void clearError() { m_error = QQmlError(); }

    void setErrorLocation(const QQmlSourceLocation &sourceLocation);
    void setErrorDescription(const QString &description);
    void setErrorObject(QObject *object);

    // Call only from catch(...) -- will re-throw if no JS exception
    void catchJavaScriptException(QV4::ExecutionEngine *engine);

private:

    mutable QQmlError m_error;

    QQmlDelayedError  *nextError;
    QQmlDelayedError **prevError;
};

class Q_QML_PRIVATE_EXPORT QQmlJavaScriptExpression
{
public:
    QQmlJavaScriptExpression();
    virtual ~QQmlJavaScriptExpression();

    virtual QString expressionIdentifier() = 0;
    virtual void expressionChanged() = 0;

    QV4::ReturnedValue evaluate(bool *isUndefined);
    QV4::ReturnedValue evaluate(QV4::CallData *callData, bool *isUndefined);

    inline bool notifyOnValueChanged() const;

    void setNotifyOnValueChanged(bool v);
    void resetNotifyOnValueChanged();

    inline QObject *scopeObject() const;
    inline void setScopeObject(QObject *v);

    bool isValid() const { return context() != 0; }

    QQmlContextData *context() const { return m_context; }
    void setContext(QQmlContextData *context);

    virtual void refresh();

    class DeleteWatcher {
    public:
        inline DeleteWatcher(QQmlJavaScriptExpression *);
        inline ~DeleteWatcher();
        inline bool wasDeleted() const;
    private:
        friend class QQmlJavaScriptExpression;
        QObject *_c;
        QQmlJavaScriptExpression **_w;
        QQmlJavaScriptExpression *_s;
    };

    inline bool hasError() const;
    inline bool hasDelayedError() const;
    QQmlError error(QQmlEngine *) const;
    void clearError();
    void clearGuards();
    QQmlDelayedError *delayedError();

    static QV4::ReturnedValue evalFunction(QQmlContextData *ctxt, QObject *scope,
                                                     const QString &code, const QString &filename,
                                                     quint16 line);
protected:
    void createQmlBinding(QQmlContextData *ctxt, QObject *scope, const QString &code, const QString &filename, quint16 line);

private:
    friend class QQmlContextData;
    friend class QQmlPropertyCapture;
    friend void QQmlJavaScriptExpressionGuard_callback(QQmlNotifierEndpoint *, void **);

    QQmlDelayedError *m_error;

    // We store some flag bits in the following flag pointers.
    //    activeGuards:flag1  - notifyOnValueChanged
    //    activeGuards:flag2  - useSharedContext
    QBiPointer<QObject, DeleteWatcher> m_scopeObject;
    QForwardFieldList<QQmlJavaScriptExpressionGuard, &QQmlJavaScriptExpressionGuard::next> activeGuards;

    QQmlContextData *m_context;
    QQmlJavaScriptExpression **m_prevExpression;
    QQmlJavaScriptExpression  *m_nextExpression;

protected:
    QV4::PersistentValue m_function;
};

class QQmlPropertyCapture
{
public:
    QQmlPropertyCapture(QQmlEngine *engine, QQmlJavaScriptExpression *e, QQmlJavaScriptExpression::DeleteWatcher *w)
    : engine(engine), expression(e), watcher(w), errorString(0) { }

    ~QQmlPropertyCapture()  {
        Q_ASSERT(guards.isEmpty());
        Q_ASSERT(errorString == 0);
    }

    void captureProperty(QQmlNotifier *);
    void captureProperty(QObject *, int, int);

    static void registerQmlDependencies(QV4::ExecutionEngine *engine, const QV4::CompiledData::Function *compiledFunction);

    QQmlEngine *engine;
    QQmlJavaScriptExpression *expression;
    QQmlJavaScriptExpression::DeleteWatcher *watcher;
    QFieldList<QQmlJavaScriptExpressionGuard, &QQmlJavaScriptExpressionGuard::next> guards;
    QStringList *errorString;
};

QQmlJavaScriptExpression::DeleteWatcher::DeleteWatcher(QQmlJavaScriptExpression *e)
: _c(0), _w(0), _s(e)
{
    if (e->m_scopeObject.isT1()) {
        _w = &_s;
        _c = e->m_scopeObject.asT1();
        e->m_scopeObject = this;
    } else {
        // Another watcher is already registered
        _w = &e->m_scopeObject.asT2()->_s;
    }
}

QQmlJavaScriptExpression::DeleteWatcher::~DeleteWatcher()
{
    Q_ASSERT(*_w == 0 || (*_w == _s && _s->m_scopeObject.isT2()));
    if (*_w && _s->m_scopeObject.asT2() == this)
        _s->m_scopeObject = _c;
}

bool QQmlJavaScriptExpression::DeleteWatcher::wasDeleted() const
{
    return *_w == 0;
}

bool QQmlJavaScriptExpression::notifyOnValueChanged() const
{
    return activeGuards.flag();
}

QObject *QQmlJavaScriptExpression::scopeObject() const
{
    if (m_scopeObject.isT1()) return m_scopeObject.asT1();
    else return m_scopeObject.asT2()->_c;
}

void QQmlJavaScriptExpression::setScopeObject(QObject *v)
{
    if (m_scopeObject.isT1()) m_scopeObject = v;
    else m_scopeObject.asT2()->_c = v;
}

bool QQmlJavaScriptExpression::hasError() const
{
    return m_error && m_error->isValid();
}

bool QQmlJavaScriptExpression::hasDelayedError() const
{
    return m_error;
}

QQmlJavaScriptExpressionGuard::QQmlJavaScriptExpressionGuard(QQmlJavaScriptExpression *e)
    : QQmlNotifierEndpoint(QQmlNotifierEndpoint::QQmlJavaScriptExpressionGuard),
      expression(e), next(0)
{
}

QQmlJavaScriptExpressionGuard *
QQmlJavaScriptExpressionGuard::New(QQmlJavaScriptExpression *e,
                                           QQmlEngine *engine)
{
    Q_ASSERT(e);
    return QQmlEnginePrivate::get(engine)->jsExpressionGuardPool.New(e);
}

void QQmlJavaScriptExpressionGuard::Delete()
{
    QRecyclePool<QQmlJavaScriptExpressionGuard>::Delete(this);
}


QT_END_NAMESPACE

#endif // QQMLJAVASCRIPTEXPRESSION_P_H
