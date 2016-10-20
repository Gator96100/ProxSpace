/****************************************************************************
** Meta object code from reading C++ file 'qnetworkaccessbackend_p.h'
**
** Created: Thu Feb 11 02:09:31 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../access/qnetworkaccessbackend_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qnetworkaccessbackend_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QNetworkAccessBackend[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      28,   23,   22,   22, 0x0a,
      60,   22,   22,   22, 0x09,
      88,   71,   22,   22, 0x09,
     142,  131,   22,   22, 0x09,
     206,  201,   22,   22, 0x09,
     246,   22,   22,   22, 0x09,
     276,  264,   22,   22, 0x09,
     310,  303,   22,   22, 0x09,
     359,  338,   22,   22, 0x09,

       0        // eod
};

static const char qt_meta_stringdata_QNetworkAccessBackend[] = {
    "QNetworkAccessBackend\0\0data\0"
    "writeDownstreamData(QIODevice*)\0"
    "finished()\0code,errorString\0"
    "error(QNetworkReply::NetworkError,QString)\0"
    "proxy,auth\0"
    "proxyAuthenticationRequired(QNetworkProxy,QAuthenticator*)\0"
    "auth\0authenticationRequired(QAuthenticator*)\0"
    "metaDataChanged()\0destination\0"
    "redirectionRequested(QUrl)\0errors\0"
    "sslErrors(QList<QSslError>)\0"
    "bytesSent,bytesTotal\0"
    "emitReplyUploadProgress(qint64,qint64)\0"
};

const QMetaObject QNetworkAccessBackend::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QNetworkAccessBackend,
      qt_meta_data_QNetworkAccessBackend, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QNetworkAccessBackend::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QNetworkAccessBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QNetworkAccessBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QNetworkAccessBackend))
        return static_cast<void*>(const_cast< QNetworkAccessBackend*>(this));
    return QObject::qt_metacast(_clname);
}

int QNetworkAccessBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: writeDownstreamData((*reinterpret_cast< QIODevice*(*)>(_a[1]))); break;
        case 1: finished(); break;
        case 2: error((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 3: proxyAuthenticationRequired((*reinterpret_cast< const QNetworkProxy(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        case 4: authenticationRequired((*reinterpret_cast< QAuthenticator*(*)>(_a[1]))); break;
        case 5: metaDataChanged(); break;
        case 6: redirectionRequested((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        case 7: sslErrors((*reinterpret_cast< const QList<QSslError>(*)>(_a[1]))); break;
        case 8: emitReplyUploadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 9;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
