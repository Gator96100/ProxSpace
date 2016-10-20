/****************************************************************************
** Meta object code from reading C++ file 'qhttpnetworkconnectionchannel_p.h'
**
** Created: Thu Feb 11 02:08:28 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../access/qhttpnetworkconnectionchannel_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qhttpnetworkconnectionchannel_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QHttpNetworkConnectionChannel[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      31,   30,   30,   30, 0x09,
      55,   49,   30,   30, 0x09,
      79,   30,   30,   30, 0x09,
      94,   30,   30,   30, 0x09,
     112,   30,   30,   30, 0x09,
     127,   30,   30,   30, 0x09,
     177,  166,   30,   30, 0x09,
     239,   30,   30,   30, 0x09,
     264,   30,   30,   30, 0x09,
     286,  279,   30,   30, 0x09,
     317,   49,   30,   30, 0x09,

       0        // eod
};

static const char qt_meta_stringdata_QHttpNetworkConnectionChannel[] = {
    "QHttpNetworkConnectionChannel\0\0"
    "_q_receiveReply()\0bytes\0_q_bytesWritten(qint64)\0"
    "_q_readyRead()\0_q_disconnected()\0"
    "_q_connected()\0_q_error(QAbstractSocket::SocketError)\0"
    "proxy,auth\0"
    "_q_proxyAuthenticationRequired(QNetworkProxy,QAuthenticator*)\0"
    "_q_uploadDataReadyRead()\0_q_encrypted()\0"
    "errors\0_q_sslErrors(QList<QSslError>)\0"
    "_q_encryptedBytesWritten(qint64)\0"
};

const QMetaObject QHttpNetworkConnectionChannel::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QHttpNetworkConnectionChannel,
      qt_meta_data_QHttpNetworkConnectionChannel, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QHttpNetworkConnectionChannel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QHttpNetworkConnectionChannel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QHttpNetworkConnectionChannel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QHttpNetworkConnectionChannel))
        return static_cast<void*>(const_cast< QHttpNetworkConnectionChannel*>(this));
    return QObject::qt_metacast(_clname);
}

int QHttpNetworkConnectionChannel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _q_receiveReply(); break;
        case 1: _q_bytesWritten((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 2: _q_readyRead(); break;
        case 3: _q_disconnected(); break;
        case 4: _q_connected(); break;
        case 5: _q_error((*reinterpret_cast< QAbstractSocket::SocketError(*)>(_a[1]))); break;
        case 6: _q_proxyAuthenticationRequired((*reinterpret_cast< const QNetworkProxy(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        case 7: _q_uploadDataReadyRead(); break;
        case 8: _q_encrypted(); break;
        case 9: _q_sslErrors((*reinterpret_cast< const QList<QSslError>(*)>(_a[1]))); break;
        case 10: _q_encryptedBytesWritten((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 11;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
