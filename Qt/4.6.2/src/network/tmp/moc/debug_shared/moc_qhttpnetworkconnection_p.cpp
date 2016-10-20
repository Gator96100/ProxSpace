/****************************************************************************
** Meta object code from reading C++ file 'qhttpnetworkconnection_p.h'
**
** Created: Thu Feb 11 02:08:26 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../access/qhttpnetworkconnection_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qhttpnetworkconnection_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QHttpNetworkConnection[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: signature, parameters, type, tag, flags
      31,   24,   23,   23, 0x05,
      90,   59,   23,   23, 0x05,
     199,  179,   23,   23, 0x25,
     291,  258,   23,   23, 0x05,
     403,  381,   23,   23, 0x25,
     480,  463,   23,   23, 0x05,
     533,  523,   23,   23, 0x25,

 // slots: signature, parameters, type, tag, flags
     568,   23,   23,   23, 0x08,
     590,   23,   23,   23, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QHttpNetworkConnection[] = {
    "QHttpNetworkConnection\0\0errors\0"
    "sslErrors(QList<QSslError>)\0"
    "proxy,authenticator,connection\0"
    "proxyAuthenticationRequired(QNetworkProxy,QAuthenticator*,const QHttpN"
    "etworkConnection*)\0"
    "proxy,authenticator\0"
    "proxyAuthenticationRequired(QNetworkProxy,QAuthenticator*)\0"
    "request,authenticator,connection\0"
    "authenticationRequired(QHttpNetworkRequest,QAuthenticator*,const QHttp"
    "NetworkConnection*)\0"
    "request,authenticator\0"
    "authenticationRequired(QHttpNetworkRequest,QAuthenticator*)\0"
    "errorCode,detail\0"
    "error(QNetworkReply::NetworkError,QString)\0"
    "errorCode\0error(QNetworkReply::NetworkError)\0"
    "_q_startNextRequest()\0"
    "_q_restartAuthPendingRequests()\0"
};

const QMetaObject QHttpNetworkConnection::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QHttpNetworkConnection,
      qt_meta_data_QHttpNetworkConnection, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QHttpNetworkConnection::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QHttpNetworkConnection::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QHttpNetworkConnection::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QHttpNetworkConnection))
        return static_cast<void*>(const_cast< QHttpNetworkConnection*>(this));
    return QObject::qt_metacast(_clname);
}

int QHttpNetworkConnection::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: sslErrors((*reinterpret_cast< const QList<QSslError>(*)>(_a[1]))); break;
        case 1: proxyAuthenticationRequired((*reinterpret_cast< const QNetworkProxy(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2])),(*reinterpret_cast< const QHttpNetworkConnection*(*)>(_a[3]))); break;
        case 2: proxyAuthenticationRequired((*reinterpret_cast< const QNetworkProxy(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        case 3: authenticationRequired((*reinterpret_cast< const QHttpNetworkRequest(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2])),(*reinterpret_cast< const QHttpNetworkConnection*(*)>(_a[3]))); break;
        case 4: authenticationRequired((*reinterpret_cast< const QHttpNetworkRequest(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        case 5: error((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 6: error((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1]))); break;
        case 7: d_func()->_q_startNextRequest(); break;
        case 8: d_func()->_q_restartAuthPendingRequests(); break;
        default: ;
        }
        _id -= 9;
    }
    return _id;
}

// SIGNAL 0
void QHttpNetworkConnection::sslErrors(const QList<QSslError> & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QHttpNetworkConnection::proxyAuthenticationRequired(const QNetworkProxy & _t1, QAuthenticator * _t2, const QHttpNetworkConnection * _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 3
void QHttpNetworkConnection::authenticationRequired(const QHttpNetworkRequest & _t1, QAuthenticator * _t2, const QHttpNetworkConnection * _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 5
void QHttpNetworkConnection::error(QNetworkReply::NetworkError _t1, const QString & _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}
QT_END_MOC_NAMESPACE
