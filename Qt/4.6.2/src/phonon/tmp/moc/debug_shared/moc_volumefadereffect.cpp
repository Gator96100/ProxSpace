/****************************************************************************
** Meta object code from reading C++ file 'volumefadereffect.h'
**
** Created: Thu Feb 11 02:59:39 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/volumefadereffect.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'volumefadereffect.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__VolumeFaderEffect[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       3,   44, // properties
       1,   53, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      36,   27,   26,   26, 0x0a,
      48,   27,   26,   26, 0x0a,
      68,   61,   26,   26, 0x0a,
      99,   85,   26,   26, 0x0a,
     130,  124,   26,   26, 0x0a,
     170,  154,   26,   26, 0x0a,

 // properties: name, type, flags
      61,  188, 0x87095103,
      85,  194, 0x06095103,
     211,  201, 0x0009510b,

 // enums: name, flags, count, data
     201, 0x0,    4,   57,

 // enum data: key, value
     221, uint(Phonon::VolumeFaderEffect::Fade3Decibel),
     234, uint(Phonon::VolumeFaderEffect::Fade6Decibel),
     247, uint(Phonon::VolumeFaderEffect::Fade9Decibel),
     260, uint(Phonon::VolumeFaderEffect::Fade12Decibel),

       0        // eod
};

static const char qt_meta_stringdata_Phonon__VolumeFaderEffect[] = {
    "Phonon::VolumeFaderEffect\0\0fadeTime\0"
    "fadeIn(int)\0fadeOut(int)\0volume\0"
    "setVolume(float)\0volumeDecibel\0"
    "setVolumeDecibel(double)\0curve\0"
    "setFadeCurve(FadeCurve)\0volume,fadeTime\0"
    "fadeTo(float,int)\0float\0double\0FadeCurve\0"
    "fadeCurve\0Fade3Decibel\0Fade6Decibel\0"
    "Fade9Decibel\0Fade12Decibel\0"
};

const QMetaObject Phonon::VolumeFaderEffect::staticMetaObject = {
    { &Effect::staticMetaObject, qt_meta_stringdata_Phonon__VolumeFaderEffect,
      qt_meta_data_Phonon__VolumeFaderEffect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::VolumeFaderEffect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::VolumeFaderEffect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::VolumeFaderEffect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__VolumeFaderEffect))
        return static_cast<void*>(const_cast< VolumeFaderEffect*>(this));
    return Effect::qt_metacast(_clname);
}

int Phonon::VolumeFaderEffect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = Effect::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: fadeIn((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: fadeOut((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: setVolume((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 3: setVolumeDecibel((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 4: setFadeCurve((*reinterpret_cast< FadeCurve(*)>(_a[1]))); break;
        case 5: fadeTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< float*>(_v) = volume(); break;
        case 1: *reinterpret_cast< double*>(_v) = volumeDecibel(); break;
        case 2: *reinterpret_cast< FadeCurve*>(_v) = fadeCurve(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setVolume(*reinterpret_cast< float*>(_v)); break;
        case 1: setVolumeDecibel(*reinterpret_cast< double*>(_v)); break;
        case 2: setFadeCurve(*reinterpret_cast< FadeCurve*>(_v)); break;
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
QT_END_MOC_NAMESPACE
