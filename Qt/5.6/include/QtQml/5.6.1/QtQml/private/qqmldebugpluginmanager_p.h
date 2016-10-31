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

#ifndef QQMLDEBUGPLUGINMANAGER_P_H
#define QQMLDEBUGPLUGINMANAGER_P_H

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

#include <QDebug>
#include <private/qtqmlglobal_p.h>
#include <private/qfactoryloader_p.h>

QT_BEGIN_NAMESPACE

#if defined(QT_NO_QML_DEBUGGER)

#define Q_QML_DEBUG_PLUGIN_LOADER(interfaceName)\
    interfaceName *load##interfaceName(const QString &key)\
    {\
        qWarning() << "Qml Debugger: QtQml is not configured for debugging. Ignoring request for"\
                   << "debug plugin" << key;\
        return 0;\
    }\
    QList<QJsonObject> metaDataFor##interfaceName()\
    {\
        return QList<QJsonObject>();\
    }
#define Q_QML_IMPORT_DEBUG_PLUGIN(className)

#else // QT_NO_QML_DEBUGGER

#define Q_QML_DEBUG_PLUGIN_LOADER(interfaceName)\
    Q_GLOBAL_STATIC_WITH_ARGS(QFactoryLoader, interfaceName##Loader,\
        (interfaceName##Factory_iid, QLatin1String("/qmltooling")))\
    interfaceName *load##interfaceName(const QString &key)\
    {\
        return qLoadPlugin<interfaceName, interfaceName##Factory>(interfaceName##Loader(), key);\
    }\
    QList<QJsonObject> metaDataFor##interfaceName()\
    {\
        return interfaceName##Loader()->metaData();\
    }

#endif // QT_NO_QML_DEBUGGER

QT_END_NAMESPACE
#endif // QQMLDEBUGPLUGINMANAGER_P_H
