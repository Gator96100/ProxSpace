/****************************************************************************
** Meta object code from reading C++ file 'qabstracttransition.h'
**
** Created: Thu Feb 11 02:05:25 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../statemachine/qabstracttransition.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qabstracttransition.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QAbstractTransition[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       3,   19, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      21,   20,   20,   20, 0x05,

 // properties: name, type, flags
      41,   33, 0x00095009,
      69,   53, 0x0009510b,
     104,   81, 0x0009510b,

       0        // eod
};

static const char qt_meta_stringdata_QAbstractTransition[] = {
    "QAbstractTransition\0\0triggered()\0"
    "QState*\0sourceState\0QAbstractState*\0"
    "targetState\0QList<QAbstractState*>\0"
    "targetStates\0"
};

const QMetaObject QAbstractTransition::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAbstractTransition,
      qt_meta_data_QAbstractTransition, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAbstractTransition::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAbstractTransition::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAbstractTransition::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAbstractTransition))
        return static_cast<void*>(const_cast< QAbstractTransition*>(this));
    return QObject::qt_metacast(_clname);
}

int QAbstractTransition::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: triggered(); break;
        default: ;
        }
        _id -= 1;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QState**>(_v) = sourceState(); break;
        case 1: *reinterpret_cast< QAbstractState**>(_v) = targetState(); break;
        case 2: *reinterpret_cast< QList<QAbstractState*>*>(_v) = targetStates(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 1: setTargetState(*reinterpret_cast< QAbstractState**>(_v)); break;
        case 2: setTargetStates(*reinterpret_cast< QList<QAbstractState*>*>(_v)); break;
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
void QAbstractTransition::triggered()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
