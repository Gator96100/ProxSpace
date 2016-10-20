/****************************************************************************
** Meta object code from reading C++ file 'qhistorystate.h'
**
** Created: Thu Feb 11 02:05:24 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../statemachine/qhistorystate.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qhistorystate.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QHistoryState[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       2,   14, // properties
       1,   20, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // properties: name, type, flags
      30,   14, 0x0009510b,
      55,   43, 0x0009510b,

 // enums: name, flags, count, data
      43, 0x0,    2,   24,

 // enum data: key, value
      67, uint(QHistoryState::ShallowHistory),
      82, uint(QHistoryState::DeepHistory),

       0        // eod
};

static const char qt_meta_stringdata_QHistoryState[] = {
    "QHistoryState\0QAbstractState*\0"
    "defaultState\0HistoryType\0historyType\0"
    "ShallowHistory\0DeepHistory\0"
};

const QMetaObject QHistoryState::staticMetaObject = {
    { &QAbstractState::staticMetaObject, qt_meta_stringdata_QHistoryState,
      qt_meta_data_QHistoryState, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QHistoryState::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QHistoryState::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QHistoryState::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QHistoryState))
        return static_cast<void*>(const_cast< QHistoryState*>(this));
    return QAbstractState::qt_metacast(_clname);
}

int QHistoryState::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractState::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
     if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QAbstractState**>(_v) = defaultState(); break;
        case 1: *reinterpret_cast< HistoryType*>(_v) = historyType(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setDefaultState(*reinterpret_cast< QAbstractState**>(_v)); break;
        case 1: setHistoryType(*reinterpret_cast< HistoryType*>(_v)); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
