/****************************************************************************
** Meta object code from reading C++ file 'qnetworkaccesshttpbackend_p.h'
**
** Created: Thu Feb 11 02:09:33 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../access/qnetworkaccesshttpbackend_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qnetworkaccesshttpbackend_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QNetworkAccessHttpBackend[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      27,   26,   26,   26, 0x08,
      44,   26,   26,   26, 0x08,
      60,   26,   26,   26, 0x08,
      94,   81,   26,   26, 0x08,
     176,  158,   26,   26, 0x08,
     237,  228,  223,   26, 0x08,
     278,   26,   26,   26, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QNetworkAccessHttpBackend[] = {
    "QNetworkAccessHttpBackend\0\0replyReadyRead()\0"
    "replyFinished()\0replyHeaderChanged()\0"
    "request,auth\0"
    "httpAuthenticationRequired(QHttpNetworkRequest,QAuthenticator*)\0"
    "error,errorString\0"
    "httpError(QNetworkReply::NetworkError,QString)\0"
    "bool\0metaData\0sendCacheContents(QNetworkCacheMetaData)\0"
    "finished()\0"
};

const QMetaObject QNetworkAccessHttpBackend::staticMetaObject = {
    { &QNetworkAccessBackend::staticMetaObject, qt_meta_stringdata_QNetworkAccessHttpBackend,
      qt_meta_data_QNetworkAccessHttpBackend, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QNetworkAccessHttpBackend::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QNetworkAccessHttpBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QNetworkAccessHttpBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QNetworkAccessHttpBackend))
        return static_cast<void*>(const_cast< QNetworkAccessHttpBackend*>(this));
    return QNetworkAccessBackend::qt_metacast(_clname);
}

int QNetworkAccessHttpBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QNetworkAccessBackend::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: replyReadyRead(); break;
        case 1: replyFinished(); break;
        case 2: replyHeaderChanged(); break;
        case 3: httpAuthenticationRequired((*reinterpret_cast< const QHttpNetworkRequest(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        case 4: httpError((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 5: { bool _r = sendCacheContents((*reinterpret_cast< const QNetworkCacheMetaData(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 6: finished(); break;
        default: ;
        }
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
