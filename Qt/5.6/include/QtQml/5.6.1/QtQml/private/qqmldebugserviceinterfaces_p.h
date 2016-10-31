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

#ifndef QQMLDEBUGSERVICEINTERFACES_P_H
#define QQMLDEBUGSERVICEINTERFACES_P_H

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

#include <QtCore/qstring.h>
#include <private/qtqmlglobal_p.h>
#include <private/qqmldebugservice_p.h>
#include <private/qqmldebugstatesdelegate_p.h>
#include <private/qqmlabstractprofileradapter_p.h>
#include <private/qqmlboundsignal_p.h>

#include <limits>

QT_BEGIN_NAMESPACE

class Q_QML_PRIVATE_EXPORT QV4DebugService : protected QQmlDebugService
{
    Q_OBJECT
public:
    virtual void signalEmitted(const QString &signal) = 0;

protected:
    friend class QQmlDebugConnector;

    QV4DebugService(float version, QObject *parent = 0) :
        QQmlDebugService(s_key, version, parent) {}

    static const QString s_key;
};

class Q_QML_PRIVATE_EXPORT QQmlProfilerService : protected QQmlDebugService
{
    Q_OBJECT
public:
    virtual void addGlobalProfiler(QQmlAbstractProfilerAdapter *profiler) = 0;
    virtual void removeGlobalProfiler(QQmlAbstractProfilerAdapter *profiler) = 0;

    virtual void startProfiling(QQmlEngine *engine,
                                quint64 features = std::numeric_limits<quint64>::max()) = 0;
    virtual void stopProfiling(QQmlEngine *engine) = 0;

    virtual void dataReady(QQmlAbstractProfilerAdapter *profiler) = 0;

protected:
    friend class QQmlDebugConnector;

    QQmlProfilerService(float version, QObject *parent = 0) :
        QQmlDebugService(s_key, version, parent) {}

    static const QString s_key;
};

class Q_QML_PRIVATE_EXPORT QQmlEngineDebugService : protected QQmlDebugService
{
    Q_OBJECT
public:
    virtual void objectCreated(QQmlEngine *engine, QObject *object) = 0;
    virtual void setStatesDelegate(QQmlDebugStatesDelegate *) = 0;

protected:
    friend class QQmlDebugConnector;

    QQmlEngineDebugService(float version, QObject *parent = 0) :
        QQmlDebugService(s_key, version, parent) {}

    QQmlBoundSignal *nextSignal(QQmlBoundSignal *prev) { return prev->m_nextSignal; }

    static const QString s_key;
};

class Q_QML_PRIVATE_EXPORT QQmlInspectorService : protected QQmlDebugService
{
    Q_OBJECT
public:
    virtual void addView(QObject *) = 0;
    virtual void removeView(QObject *) = 0;

protected:
    friend class QQmlDebugConnector;

    QQmlInspectorService(float version, QObject *parent = 0) :
        QQmlDebugService(s_key, version, parent) {}

    static const QString s_key;
};

class Q_QML_PRIVATE_EXPORT QQmlNativeDebugService : protected QQmlDebugService
{
    Q_OBJECT

protected:
    friend class QQmlDebugConnector;

    QQmlNativeDebugService(float version, QObject *parent = 0)
        : QQmlDebugService(s_key, version,  parent) {}

    static const QString s_key;
};

QT_END_NAMESPACE

#endif // QQMLDEBUGSERVICEINTERFACES_P_H

