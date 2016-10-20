/****************************************************************************
** Meta object code from reading C++ file 'qvariantanimation.h'
**
** Created: Thu Feb 11 02:02:39 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../animation/qvariantanimation.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qvariantanimation.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QVariantAnimation[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       5,   19, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      25,   19,   18,   18, 0x05,

 // properties: name, type, flags
      57,   48, 0xff095103,
      68,   48, 0xff095103,
      77,   48, 0xff495001,
      94,   90, 0x02095103,
     116,  103, 0x0009510b,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_QVariantAnimation[] = {
    "QVariantAnimation\0\0value\0"
    "valueChanged(QVariant)\0QVariant\0"
    "startValue\0endValue\0currentValue\0int\0"
    "duration\0QEasingCurve\0easingCurve\0"
};

const QMetaObject QVariantAnimation::staticMetaObject = {
    { &QAbstractAnimation::staticMetaObject, qt_meta_stringdata_QVariantAnimation,
      qt_meta_data_QVariantAnimation, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QVariantAnimation::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QVariantAnimation::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QVariantAnimation::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QVariantAnimation))
        return static_cast<void*>(const_cast< QVariantAnimation*>(this));
    return QAbstractAnimation::qt_metacast(_clname);
}

int QVariantAnimation::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractAnimation::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: valueChanged((*reinterpret_cast< const QVariant(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 1;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QVariant*>(_v) = startValue(); break;
        case 1: *reinterpret_cast< QVariant*>(_v) = endValue(); break;
        case 2: *reinterpret_cast< QVariant*>(_v) = currentValue(); break;
        case 3: *reinterpret_cast< int*>(_v) = duration(); break;
        case 4: *reinterpret_cast< QEasingCurve*>(_v) = easingCurve(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setStartValue(*reinterpret_cast< QVariant*>(_v)); break;
        case 1: setEndValue(*reinterpret_cast< QVariant*>(_v)); break;
        case 3: setDuration(*reinterpret_cast< int*>(_v)); break;
        case 4: setEasingCurve(*reinterpret_cast< QEasingCurve*>(_v)); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QVariantAnimation::valueChanged(const QVariant & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
