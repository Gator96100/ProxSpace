/****************************************************************************
** Meta object code from reading C++ file 'effectwidget.h'
**
** Created: Thu Feb 11 03:00:03 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/effectwidget.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'effectwidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__EffectWidget[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      30,   22,   21,   21, 0x08,
      64,   58,   21,   21, 0x08,
      88,   58,   21,   21, 0x08,
     118,   21,   21,   21, 0x08,
     149,   21,   21,   21, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__EffectWidget[] = {
    "Phonon::EffectWidget\0\0checked\0"
    "_k_setToggleParameter(bool)\0value\0"
    "_k_setIntParameter(int)\0"
    "_k_setDoubleParameter(double)\0"
    "_k_setStringParameter(QString)\0"
    "_k_setSliderParameter(int)\0"
};

const QMetaObject Phonon::EffectWidget::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_Phonon__EffectWidget,
      qt_meta_data_Phonon__EffectWidget, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::EffectWidget::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::EffectWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::EffectWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__EffectWidget))
        return static_cast<void*>(const_cast< EffectWidget*>(this));
    return QWidget::qt_metacast(_clname);
}

int Phonon::EffectWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: k_func()->_k_setToggleParameter((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: k_func()->_k_setIntParameter((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: k_func()->_k_setDoubleParameter((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 3: k_func()->_k_setStringParameter((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 4: k_func()->_k_setSliderParameter((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 5;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
