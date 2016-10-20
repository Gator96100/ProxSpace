/****************************************************************************
** Meta object code from reading C++ file 'seekslider.h'
**
** Created: Thu Feb 11 02:59:59 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/seekslider.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'seekslider.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__SeekSlider[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       6,   64, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      20,   19,   19,   19, 0x0a,
      52,   19,   19,   19, 0x0a,
      78,   73,   19,   19, 0x0a,
      97,   19,   19,   19, 0x0a,
     126,   19,   19,   19, 0x08,
     157,   19,   19,   19, 0x08,
     170,   19,   19,   19, 0x08,
     186,   19,   19,   19, 0x08,
     204,   19,   19,   19, 0x08,
     229,   19,   19,   19, 0x08,

 // properties: name, type, flags
     260,  255, 0x01095103,
     272,  255, 0x01095103,
     285,  281, 0x02095103,
     294,  281, 0x02095103,
     321,  305, 0x0009510b,
     339,  333, 0x15095103,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__SeekSlider[] = {
    "Phonon::SeekSlider\0\0setOrientation(Qt::Orientation)\0"
    "setIconVisible(bool)\0size\0setIconSize(QSize)\0"
    "setMediaObject(MediaObject*)\0"
    "_k_stateChanged(Phonon::State)\0"
    "_k_seek(int)\0_k_tick(qint64)\0"
    "_k_length(qint64)\0_k_seekableChanged(bool)\0"
    "_k_currentSourceChanged()\0bool\0"
    "iconVisible\0tracking\0int\0pageStep\0"
    "singleStep\0Qt::Orientation\0orientation\0"
    "QSize\0iconSize\0"
};

const QMetaObject Phonon::SeekSlider::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_Phonon__SeekSlider,
      qt_meta_data_Phonon__SeekSlider, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::SeekSlider::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::SeekSlider::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::SeekSlider::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__SeekSlider))
        return static_cast<void*>(const_cast< SeekSlider*>(this));
    return QWidget::qt_metacast(_clname);
}

int Phonon::SeekSlider::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: setOrientation((*reinterpret_cast< Qt::Orientation(*)>(_a[1]))); break;
        case 1: setIconVisible((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: setIconSize((*reinterpret_cast< const QSize(*)>(_a[1]))); break;
        case 3: setMediaObject((*reinterpret_cast< MediaObject*(*)>(_a[1]))); break;
        case 4: k_func()->_k_stateChanged((*reinterpret_cast< Phonon::State(*)>(_a[1]))); break;
        case 5: k_func()->_k_seek((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: k_func()->_k_tick((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 7: k_func()->_k_length((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 8: k_func()->_k_seekableChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 9: k_func()->_k_currentSourceChanged(); break;
        default: ;
        }
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = isIconVisible(); break;
        case 1: *reinterpret_cast< bool*>(_v) = hasTracking(); break;
        case 2: *reinterpret_cast< int*>(_v) = pageStep(); break;
        case 3: *reinterpret_cast< int*>(_v) = singleStep(); break;
        case 4: *reinterpret_cast< Qt::Orientation*>(_v) = orientation(); break;
        case 5: *reinterpret_cast< QSize*>(_v) = iconSize(); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setIconVisible(*reinterpret_cast< bool*>(_v)); break;
        case 1: setTracking(*reinterpret_cast< bool*>(_v)); break;
        case 2: setPageStep(*reinterpret_cast< int*>(_v)); break;
        case 3: setSingleStep(*reinterpret_cast< int*>(_v)); break;
        case 4: setOrientation(*reinterpret_cast< Qt::Orientation*>(_v)); break;
        case 5: setIconSize(*reinterpret_cast< QSize*>(_v)); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 6;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
