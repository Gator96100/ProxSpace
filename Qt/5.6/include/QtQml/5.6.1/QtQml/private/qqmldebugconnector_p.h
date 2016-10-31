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

#ifndef QQMLDEBUGCONNECTOR_H
#define QQMLDEBUGCONNECTOR_H

#include <QtQml/qtqmlglobal.h>
#include <QtCore/QVariantList>

#include <private/qqmldebugservice_p.h>

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

QT_BEGIN_NAMESPACE

class QQmlDebugService;
class Q_QML_PRIVATE_EXPORT QQmlDebugConnector : public QObject
{
    Q_OBJECT
public:
    static void setPluginKey(const QString &key);
    static void setServices(const QStringList &services);
    static QQmlDebugConnector *instance();

    virtual bool blockingMode() const = 0;

    virtual QQmlDebugService *service(const QString &name) const = 0;

    virtual void addEngine(QQmlEngine *engine) = 0;
    virtual void removeEngine(QQmlEngine *engine) = 0;

    virtual bool addService(const QString &name, QQmlDebugService *service) = 0;
    virtual bool removeService(const QString &name) = 0;

    virtual bool open(const QVariantHash &configuration = QVariantHash()) = 0;

    template<class Service>
    static Service *service()
    {
        QQmlDebugConnector *inst = instance();
        return inst ? static_cast<Service *>(inst->service(Service::s_key)) : 0;
    }

protected:
    static QString commandLineArguments();
};

class Q_QML_PRIVATE_EXPORT QQmlDebugConnectorFactory : public QObject {
    Q_OBJECT
public:
    virtual QQmlDebugConnector *create(const QString &key) = 0;
    ~QQmlDebugConnectorFactory();
};

#define QQmlDebugConnectorFactory_iid "org.qt-project.Qt.QQmlDebugConnectorFactory"

QT_END_NAMESPACE

#endif // QQMLDEBUGCONNECTOR_H
