/****************************************************************************
** Meta object code from reading C++ file 'videowidget.h'
**
** Created: Thu Feb 11 02:59:56 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/videowidget.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'videowidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__VideoWidget[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       7,   59, // properties
       2,   80, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      32,   21,   20,   20, 0x0a,
      52,   20,   20,   20, 0x0a,
      69,   20,   20,   20, 0x0a,
      87,   20,   20,   20, 0x0a,
     115,   20,   20,   20, 0x0a,
     145,  139,   20,   20, 0x0a,
     166,  139,   20,   20, 0x0a,
     185,  139,   20,   20, 0x0a,
     199,  139,   20,   20, 0x0a,

 // properties: name, type, flags
     225,  220, 0x01095103,
     248,  236, 0x0009510b,
     270,  260, 0x0009510b,
     286,  280, (QMetaType::QReal << 24) | 0x00095103,
     297,  280, (QMetaType::QReal << 24) | 0x00095103,
     306,  280, (QMetaType::QReal << 24) | 0x00095103,
     310,  280, (QMetaType::QReal << 24) | 0x00095103,

 // enums: name, flags, count, data
     236, 0x0,    4,   88,
     260, 0x0,    2,   96,

 // enum data: key, value
     321, uint(Phonon::VideoWidget::AspectRatioAuto),
     337, uint(Phonon::VideoWidget::AspectRatioWidget),
     355, uint(Phonon::VideoWidget::AspectRatio4_3),
     370, uint(Phonon::VideoWidget::AspectRatio16_9),
     386, uint(Phonon::VideoWidget::FitInView),
     396, uint(Phonon::VideoWidget::ScaleAndCrop),

       0        // eod
};

static const char qt_meta_stringdata_Phonon__VideoWidget[] = {
    "Phonon::VideoWidget\0\0fullscreen\0"
    "setFullScreen(bool)\0exitFullScreen()\0"
    "enterFullScreen()\0setAspectRatio(AspectRatio)\0"
    "setScaleMode(ScaleMode)\0value\0"
    "setBrightness(qreal)\0setContrast(qreal)\0"
    "setHue(qreal)\0setSaturation(qreal)\0"
    "bool\0fullScreen\0AspectRatio\0aspectRatio\0"
    "ScaleMode\0scaleMode\0qreal\0brightness\0"
    "contrast\0hue\0saturation\0AspectRatioAuto\0"
    "AspectRatioWidget\0AspectRatio4_3\0"
    "AspectRatio16_9\0FitInView\0ScaleAndCrop\0"
};

const QMetaObject Phonon::VideoWidget::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_Phonon__VideoWidget,
      qt_meta_data_Phonon__VideoWidget, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::VideoWidget::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::VideoWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::VideoWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__VideoWidget))
        return static_cast<void*>(const_cast< VideoWidget*>(this));
    if (!strcmp(_clname, "Phonon::AbstractVideoOutput"))
        return static_cast< Phonon::AbstractVideoOutput*>(const_cast< VideoWidget*>(this));
    return QWidget::qt_metacast(_clname);
}

int Phonon::VideoWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: setFullScreen((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: exitFullScreen(); break;
        case 2: enterFullScreen(); break;
        case 3: setAspectRatio((*reinterpret_cast< AspectRatio(*)>(_a[1]))); break;
        case 4: setScaleMode((*reinterpret_cast< ScaleMode(*)>(_a[1]))); break;
        case 5: setBrightness((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 6: setContrast((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 7: setHue((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 8: setSaturation((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = isFullScreen(); break;
        case 1: *reinterpret_cast< AspectRatio*>(_v) = aspectRatio(); break;
        case 2: *reinterpret_cast< ScaleMode*>(_v) = scaleMode(); break;
        case 3: *reinterpret_cast< qreal*>(_v) = brightness(); break;
        case 4: *reinterpret_cast< qreal*>(_v) = contrast(); break;
        case 5: *reinterpret_cast< qreal*>(_v) = hue(); break;
        case 6: *reinterpret_cast< qreal*>(_v) = saturation(); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setFullScreen(*reinterpret_cast< bool*>(_v)); break;
        case 1: setAspectRatio(*reinterpret_cast< AspectRatio*>(_v)); break;
        case 2: setScaleMode(*reinterpret_cast< ScaleMode*>(_v)); break;
        case 3: setBrightness(*reinterpret_cast< qreal*>(_v)); break;
        case 4: setContrast(*reinterpret_cast< qreal*>(_v)); break;
        case 5: setHue(*reinterpret_cast< qreal*>(_v)); break;
        case 6: setSaturation(*reinterpret_cast< qreal*>(_v)); break;
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
