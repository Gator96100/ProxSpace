/****************************************************************************
** Meta object code from reading C++ file 'volumeslider.h'
**
** Created: Thu Feb 11 03:00:01 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/volumeslider.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'volumeslider.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__VolumeSlider[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       7,   59, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      22,   21,   21,   21, 0x0a,
      46,   21,   21,   21, 0x0a,
      78,   21,   21,   21, 0x0a,
     104,   99,   21,   21, 0x0a,
     123,   21,   21,   21, 0x0a,
     160,   21,   21,   21, 0x08,
     182,   21,   21,   21, 0x08,
     206,   21,   21,   21, 0x08,
     228,   21,   21,   21, 0x08,

 // properties: name, type, flags
     253,  247, (QMetaType::QReal << 24) | 0x00095103,
     283,  267, 0x0009510b,
     300,  295, 0x01095103,
     313,  309, 0x02095103,
     322,  309, 0x02095103,
     333,  295, 0x01095103,
     351,  345, 0x15095103,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__VolumeSlider[] = {
    "Phonon::VolumeSlider\0\0setMaximumVolume(qreal)\0"
    "setOrientation(Qt::Orientation)\0"
    "setMuteVisible(bool)\0size\0setIconSize(QSize)\0"
    "setAudioOutput(Phonon::AudioOutput*)\0"
    "_k_sliderChanged(int)\0_k_volumeChanged(qreal)\0"
    "_k_mutedChanged(bool)\0_k_buttonClicked()\0"
    "qreal\0maximumVolume\0Qt::Orientation\0"
    "orientation\0bool\0tracking\0int\0pageStep\0"
    "singleStep\0muteVisible\0QSize\0iconSize\0"
};

const QMetaObject Phonon::VolumeSlider::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_Phonon__VolumeSlider,
      qt_meta_data_Phonon__VolumeSlider, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::VolumeSlider::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::VolumeSlider::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::VolumeSlider::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__VolumeSlider))
        return static_cast<void*>(const_cast< VolumeSlider*>(this));
    return QWidget::qt_metacast(_clname);
}

int Phonon::VolumeSlider::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: setMaximumVolume((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 1: setOrientation((*reinterpret_cast< Qt::Orientation(*)>(_a[1]))); break;
        case 2: setMuteVisible((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 3: setIconSize((*reinterpret_cast< const QSize(*)>(_a[1]))); break;
        case 4: setAudioOutput((*reinterpret_cast< Phonon::AudioOutput*(*)>(_a[1]))); break;
        case 5: k_ptr->_k_sliderChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: k_ptr->_k_volumeChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 7: k_ptr->_k_mutedChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 8: k_ptr->_k_buttonClicked(); break;
        default: ;
        }
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< qreal*>(_v) = maximumVolume(); break;
        case 1: *reinterpret_cast< Qt::Orientation*>(_v) = orientation(); break;
        case 2: *reinterpret_cast< bool*>(_v) = hasTracking(); break;
        case 3: *reinterpret_cast< int*>(_v) = pageStep(); break;
        case 4: *reinterpret_cast< int*>(_v) = singleStep(); break;
        case 5: *reinterpret_cast< bool*>(_v) = isMuteVisible(); break;
        case 6: *reinterpret_cast< QSize*>(_v) = iconSize(); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setMaximumVolume(*reinterpret_cast< qreal*>(_v)); break;
        case 1: setOrientation(*reinterpret_cast< Qt::Orientation*>(_v)); break;
        case 2: setTracking(*reinterpret_cast< bool*>(_v)); break;
        case 3: setPageStep(*reinterpret_cast< int*>(_v)); break;
        case 4: setSingleStep(*reinterpret_cast< int*>(_v)); break;
        case 5: setMuteVisible(*reinterpret_cast< bool*>(_v)); break;
        case 6: setIconSize(*reinterpret_cast< QSize*>(_v)); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
