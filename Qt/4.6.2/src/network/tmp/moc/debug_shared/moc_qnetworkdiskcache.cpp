/****************************************************************************
** Meta object code from reading C++ file 'qnetworkdiskcache.h'
**
** Created: Thu Feb 11 02:09:37 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../access/qnetworkdiskcache.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qnetworkdiskcache.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QNetworkDiskCache[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      19,   18,   18,   18, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_QNetworkDiskCache[] = {
    "QNetworkDiskCache\0\0clear()\0"
};

const QMetaObject QNetworkDiskCache::staticMetaObject = {
    { &QAbstractNetworkCache::staticMetaObject, qt_meta_stringdata_QNetworkDiskCache,
      qt_meta_data_QNetworkDiskCache, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QNetworkDiskCache::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QNetworkDiskCache::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QNetworkDiskCache::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QNetworkDiskCache))
        return static_cast<void*>(const_cast< QNetworkDiskCache*>(this));
    return QAbstractNetworkCache::qt_metacast(_clname);
}

int QNetworkDiskCache::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractNetworkCache::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: clear(); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
