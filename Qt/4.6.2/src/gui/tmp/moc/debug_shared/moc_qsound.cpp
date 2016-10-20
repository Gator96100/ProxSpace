/****************************************************************************
** Meta object code from reading C++ file 'qsound.h'
**
** Created: Thu Feb 11 02:22:40 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../kernel/qsound.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qsound.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QSound[] = {

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
       8,    7,    7,    7, 0x0a,
      15,    7,    7,    7, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_QSound[] = {
    "QSound\0\0play()\0stop()\0"
};

const QMetaObject QSound::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QSound,
      qt_meta_data_QSound, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QSound::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QSound::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QSound::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QSound))
        return static_cast<void*>(const_cast< QSound*>(this));
    return QObject::qt_metacast(_clname);
}

int QSound::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: play(); break;
        case 1: stop(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
