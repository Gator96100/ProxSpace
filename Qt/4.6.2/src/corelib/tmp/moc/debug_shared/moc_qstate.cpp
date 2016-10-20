/****************************************************************************
** Meta object code from reading C++ file 'qstate.h'
**
** Created: Thu Feb 11 02:05:23 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../statemachine/qstate.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qstate.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QState[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       3,   24, // properties
       1,   33, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
       8,    7,    7,    7, 0x05,
      19,    7,    7,    7, 0x05,

 // properties: name, type, flags
      56,   40, 0x0009510b,
      69,   40, 0x0009510b,
      90,   80, 0x0009510b,

 // enums: name, flags, count, data
      80, 0x0,    2,   37,

 // enum data: key, value
     100, uint(QState::ExclusiveStates),
     116, uint(QState::ParallelStates),

       0        // eod
};

static const char qt_meta_stringdata_QState[] = {
    "QState\0\0finished()\0propertiesAssigned()\0"
    "QAbstractState*\0initialState\0errorState\0"
    "ChildMode\0childMode\0ExclusiveStates\0"
    "ParallelStates\0"
};

const QMetaObject QState::staticMetaObject = {
    { &QAbstractState::staticMetaObject, qt_meta_stringdata_QState,
      qt_meta_data_QState, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QState::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QState::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QState::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QState))
        return static_cast<void*>(const_cast< QState*>(this));
    return QAbstractState::qt_metacast(_clname);
}

int QState::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractState::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: finished(); break;
        case 1: propertiesAssigned(); break;
        default: ;
        }
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QAbstractState**>(_v) = initialState(); break;
        case 1: *reinterpret_cast< QAbstractState**>(_v) = errorState(); break;
        case 2: *reinterpret_cast< ChildMode*>(_v) = childMode(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setInitialState(*reinterpret_cast< QAbstractState**>(_v)); break;
        case 1: setErrorState(*reinterpret_cast< QAbstractState**>(_v)); break;
        case 2: setChildMode(*reinterpret_cast< ChildMode*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QState::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QState::propertiesAssigned()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
