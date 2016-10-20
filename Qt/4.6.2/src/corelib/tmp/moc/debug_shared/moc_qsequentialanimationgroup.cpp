/****************************************************************************
** Meta object code from reading C++ file 'qsequentialanimationgroup.h'
**
** Created: Thu Feb 11 02:02:42 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../animation/qsequentialanimationgroup.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qsequentialanimationgroup.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QSequentialAnimationGroup[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       1,   24, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      35,   27,   26,   26, 0x05,

 // slots: signature, parameters, type, tag, flags
      80,   26,   26,   26, 0x08,

 // properties: name, type, flags
     135,  115, 0x00495009,

 // properties: notify_signal_id
       0,

       0        // eod
};

static const char qt_meta_stringdata_QSequentialAnimationGroup[] = {
    "QSequentialAnimationGroup\0\0current\0"
    "currentAnimationChanged(QAbstractAnimation*)\0"
    "_q_uncontrolledAnimationFinished()\0"
    "QAbstractAnimation*\0currentAnimation\0"
};

const QMetaObject QSequentialAnimationGroup::staticMetaObject = {
    { &QAnimationGroup::staticMetaObject, qt_meta_stringdata_QSequentialAnimationGroup,
      qt_meta_data_QSequentialAnimationGroup, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QSequentialAnimationGroup::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QSequentialAnimationGroup::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QSequentialAnimationGroup::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QSequentialAnimationGroup))
        return static_cast<void*>(const_cast< QSequentialAnimationGroup*>(this));
    return QAnimationGroup::qt_metacast(_clname);
}

int QSequentialAnimationGroup::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAnimationGroup::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: currentAnimationChanged((*reinterpret_cast< QAbstractAnimation*(*)>(_a[1]))); break;
        case 1: d_func()->_q_uncontrolledAnimationFinished(); break;
        default: ;
        }
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QAbstractAnimation**>(_v) = currentAnimation(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QSequentialAnimationGroup::currentAnimationChanged(QAbstractAnimation * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
