/****************************************************************************
** Meta object code from reading C++ file 'qsoftkeymanager_p.h'
**
** Created: Thu Feb 11 02:22:44 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../kernel/qsoftkeymanager_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qsoftkeymanager_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QSoftKeyManager[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      21,   17,   16,   16, 0x08,
      43,   16,   16,   16, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QSoftKeyManager[] = {
    "QSoftKeyManager\0\0obj\0cleanupHash(QObject*)\0"
    "sendKeyEvent()\0"
};

const QMetaObject QSoftKeyManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QSoftKeyManager,
      qt_meta_data_QSoftKeyManager, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QSoftKeyManager::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QSoftKeyManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QSoftKeyManager::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QSoftKeyManager))
        return static_cast<void*>(const_cast< QSoftKeyManager*>(this));
    return QObject::qt_metacast(_clname);
}

int QSoftKeyManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: cleanupHash((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 1: sendKeyEvent(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
