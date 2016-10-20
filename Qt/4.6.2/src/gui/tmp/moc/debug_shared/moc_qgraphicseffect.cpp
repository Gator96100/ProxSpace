/****************************************************************************
** Meta object code from reading C++ file 'qgraphicseffect.h'
**
** Created: Thu Feb 11 02:24:24 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../effects/qgraphicseffect.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qgraphicseffect.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QGraphicsEffect[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       1,   29, // properties
       1,   33, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      25,   17,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
      53,   46,   16,   16, 0x0a,
      70,   16,   16,   16, 0x0a,

 // properties: name, type, flags
      17,   79, 0x01495103,

 // properties: notify_signal_id
       0,

 // enums: name, flags, count, data
      84, 0x1,    4,   37,

 // enum data: key, value
      96, uint(QGraphicsEffect::SourceAttached),
     111, uint(QGraphicsEffect::SourceDetached),
     126, uint(QGraphicsEffect::SourceBoundingRectChanged),
     152, uint(QGraphicsEffect::SourceInvalidated),

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsEffect[] = {
    "QGraphicsEffect\0\0enabled\0enabledChanged(bool)\0"
    "enable\0setEnabled(bool)\0update()\0bool\0"
    "ChangeFlags\0SourceAttached\0SourceDetached\0"
    "SourceBoundingRectChanged\0SourceInvalidated\0"
};

const QMetaObject QGraphicsEffect::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QGraphicsEffect,
      qt_meta_data_QGraphicsEffect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsEffect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsEffect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsEffect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsEffect))
        return static_cast<void*>(const_cast< QGraphicsEffect*>(this));
    return QObject::qt_metacast(_clname);
}

int QGraphicsEffect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: enabledChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: setEnabled((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: update(); break;
        default: ;
        }
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = isEnabled(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setEnabled(*reinterpret_cast< bool*>(_v)); break;
        }
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
void QGraphicsEffect::enabledChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
static const uint qt_meta_data_QGraphicsColorizeEffect[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       2,   34, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      31,   25,   24,   24, 0x05,
      61,   52,   24,   24, 0x05,

 // slots: signature, parameters, type, tag, flags
      86,   84,   24,   24, 0x0a,
     103,   52,   24,   24, 0x0a,

 // properties: name, type, flags
      25,  122, 0x43495103,
      52,  129, (QMetaType::QReal << 24) | 0x00495103,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsColorizeEffect[] = {
    "QGraphicsColorizeEffect\0\0color\0"
    "colorChanged(QColor)\0strength\0"
    "strengthChanged(qreal)\0c\0setColor(QColor)\0"
    "setStrength(qreal)\0QColor\0qreal\0"
};

const QMetaObject QGraphicsColorizeEffect::staticMetaObject = {
    { &QGraphicsEffect::staticMetaObject, qt_meta_stringdata_QGraphicsColorizeEffect,
      qt_meta_data_QGraphicsColorizeEffect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsColorizeEffect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsColorizeEffect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsColorizeEffect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsColorizeEffect))
        return static_cast<void*>(const_cast< QGraphicsColorizeEffect*>(this));
    return QGraphicsEffect::qt_metacast(_clname);
}

int QGraphicsColorizeEffect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGraphicsEffect::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: colorChanged((*reinterpret_cast< const QColor(*)>(_a[1]))); break;
        case 1: strengthChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 2: setColor((*reinterpret_cast< const QColor(*)>(_a[1]))); break;
        case 3: setStrength((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 4;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QColor*>(_v) = color(); break;
        case 1: *reinterpret_cast< qreal*>(_v) = strength(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setColor(*reinterpret_cast< QColor*>(_v)); break;
        case 1: setStrength(*reinterpret_cast< qreal*>(_v)); break;
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

// SIGNAL 0
void QGraphicsColorizeEffect::colorChanged(const QColor & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QGraphicsColorizeEffect::strengthChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
static const uint qt_meta_data_QGraphicsBlurEffect[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       2,   34, // properties
       2,   42, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      32,   21,   20,   20, 0x05,
      63,   57,   20,   20, 0x05,

 // slots: signature, parameters, type, tag, flags
      91,   21,   20,   20, 0x0a,
     112,   57,   20,   20, 0x0a,

 // properties: name, type, flags
      21,  136, (QMetaType::QReal << 24) | 0x00495103,
     152,  142, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,

 // enums: name, flags, count, data
     162, 0x1,    3,   50,
     142, 0x1,    3,   56,

 // enum data: key, value
     171, uint(QGraphicsBlurEffect::PerformanceHint),
     187, uint(QGraphicsBlurEffect::QualityHint),
     199, uint(QGraphicsBlurEffect::AnimationHint),
     171, uint(QGraphicsBlurEffect::PerformanceHint),
     187, uint(QGraphicsBlurEffect::QualityHint),
     199, uint(QGraphicsBlurEffect::AnimationHint),

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsBlurEffect[] = {
    "QGraphicsBlurEffect\0\0blurRadius\0"
    "blurRadiusChanged(qreal)\0hints\0"
    "blurHintsChanged(BlurHints)\0"
    "setBlurRadius(qreal)\0setBlurHints(BlurHints)\0"
    "qreal\0BlurHints\0blurHints\0BlurHint\0"
    "PerformanceHint\0QualityHint\0AnimationHint\0"
};

const QMetaObject QGraphicsBlurEffect::staticMetaObject = {
    { &QGraphicsEffect::staticMetaObject, qt_meta_stringdata_QGraphicsBlurEffect,
      qt_meta_data_QGraphicsBlurEffect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsBlurEffect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsBlurEffect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsBlurEffect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsBlurEffect))
        return static_cast<void*>(const_cast< QGraphicsBlurEffect*>(this));
    return QGraphicsEffect::qt_metacast(_clname);
}

int QGraphicsBlurEffect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGraphicsEffect::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: blurRadiusChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 1: blurHintsChanged((*reinterpret_cast< BlurHints(*)>(_a[1]))); break;
        case 2: setBlurRadius((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 3: setBlurHints((*reinterpret_cast< BlurHints(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 4;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< qreal*>(_v) = blurRadius(); break;
        case 1: *reinterpret_cast<int*>(_v) = QFlag(blurHints()); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setBlurRadius(*reinterpret_cast< qreal*>(_v)); break;
        case 1: setBlurHints(QFlag(*reinterpret_cast<int*>(_v))); break;
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

// SIGNAL 0
void QGraphicsBlurEffect::blurRadiusChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QGraphicsBlurEffect::blurHintsChanged(BlurHints _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
static const uint qt_meta_data_QGraphicsDropShadowEffect[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       5,   64, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      34,   27,   26,   26, 0x05,
      68,   57,   26,   26, 0x05,
      99,   93,   26,   26, 0x05,

 // slots: signature, parameters, type, tag, flags
     124,  120,   26,   26, 0x0a,
     149,  143,   26,   26, 0x0a,
     174,  172,   26,   26, 0x0a,
     194,  191,   26,   26, 0x0a,
     215,  212,   26,   26, 0x0a,
     233,   57,   26,   26, 0x0a,
     254,   93,   26,   26, 0x0a,

 // properties: name, type, flags
      27,  271, 0x1a495103,
     285,  279, (QMetaType::QReal << 24) | 0x00495103,
     293,  279, (QMetaType::QReal << 24) | 0x00495103,
      57,  279, (QMetaType::QReal << 24) | 0x00495103,
      93,  301, 0x43495103,

 // properties: notify_signal_id
       0,
       0,
       0,
       1,
       2,

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsDropShadowEffect[] = {
    "QGraphicsDropShadowEffect\0\0offset\0"
    "offsetChanged(QPointF)\0blurRadius\0"
    "blurRadiusChanged(qreal)\0color\0"
    "colorChanged(QColor)\0ofs\0setOffset(QPointF)\0"
    "dx,dy\0setOffset(qreal,qreal)\0d\0"
    "setOffset(qreal)\0dx\0setXOffset(qreal)\0"
    "dy\0setYOffset(qreal)\0setBlurRadius(qreal)\0"
    "setColor(QColor)\0QPointF\0qreal\0xOffset\0"
    "yOffset\0QColor\0"
};

const QMetaObject QGraphicsDropShadowEffect::staticMetaObject = {
    { &QGraphicsEffect::staticMetaObject, qt_meta_stringdata_QGraphicsDropShadowEffect,
      qt_meta_data_QGraphicsDropShadowEffect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsDropShadowEffect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsDropShadowEffect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsDropShadowEffect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsDropShadowEffect))
        return static_cast<void*>(const_cast< QGraphicsDropShadowEffect*>(this));
    return QGraphicsEffect::qt_metacast(_clname);
}

int QGraphicsDropShadowEffect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGraphicsEffect::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: offsetChanged((*reinterpret_cast< const QPointF(*)>(_a[1]))); break;
        case 1: blurRadiusChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 2: colorChanged((*reinterpret_cast< const QColor(*)>(_a[1]))); break;
        case 3: setOffset((*reinterpret_cast< const QPointF(*)>(_a[1]))); break;
        case 4: setOffset((*reinterpret_cast< qreal(*)>(_a[1])),(*reinterpret_cast< qreal(*)>(_a[2]))); break;
        case 5: setOffset((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 6: setXOffset((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 7: setYOffset((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 8: setBlurRadius((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 9: setColor((*reinterpret_cast< const QColor(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QPointF*>(_v) = offset(); break;
        case 1: *reinterpret_cast< qreal*>(_v) = xOffset(); break;
        case 2: *reinterpret_cast< qreal*>(_v) = yOffset(); break;
        case 3: *reinterpret_cast< qreal*>(_v) = blurRadius(); break;
        case 4: *reinterpret_cast< QColor*>(_v) = color(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setOffset(*reinterpret_cast< QPointF*>(_v)); break;
        case 1: setXOffset(*reinterpret_cast< qreal*>(_v)); break;
        case 2: setYOffset(*reinterpret_cast< qreal*>(_v)); break;
        case 3: setBlurRadius(*reinterpret_cast< qreal*>(_v)); break;
        case 4: setColor(*reinterpret_cast< QColor*>(_v)); break;
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
void QGraphicsDropShadowEffect::offsetChanged(const QPointF & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QGraphicsDropShadowEffect::blurRadiusChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QGraphicsDropShadowEffect::colorChanged(const QColor & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
static const uint qt_meta_data_QGraphicsOpacityEffect[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       2,   34, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      32,   24,   23,   23, 0x05,
      59,   54,   23,   23, 0x05,

 // slots: signature, parameters, type, tag, flags
      86,   24,   23,   23, 0x0a,
     104,   54,   23,   23, 0x0a,

 // properties: name, type, flags
      24,  127, (QMetaType::QReal << 24) | 0x00495103,
     140,  133, 0x42495103,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsOpacityEffect[] = {
    "QGraphicsOpacityEffect\0\0opacity\0"
    "opacityChanged(qreal)\0mask\0"
    "opacityMaskChanged(QBrush)\0setOpacity(qreal)\0"
    "setOpacityMask(QBrush)\0qreal\0QBrush\0"
    "opacityMask\0"
};

const QMetaObject QGraphicsOpacityEffect::staticMetaObject = {
    { &QGraphicsEffect::staticMetaObject, qt_meta_stringdata_QGraphicsOpacityEffect,
      qt_meta_data_QGraphicsOpacityEffect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsOpacityEffect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsOpacityEffect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsOpacityEffect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsOpacityEffect))
        return static_cast<void*>(const_cast< QGraphicsOpacityEffect*>(this));
    return QGraphicsEffect::qt_metacast(_clname);
}

int QGraphicsOpacityEffect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGraphicsEffect::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: opacityChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 1: opacityMaskChanged((*reinterpret_cast< const QBrush(*)>(_a[1]))); break;
        case 2: setOpacity((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 3: setOpacityMask((*reinterpret_cast< const QBrush(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 4;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< qreal*>(_v) = opacity(); break;
        case 1: *reinterpret_cast< QBrush*>(_v) = opacityMask(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setOpacity(*reinterpret_cast< qreal*>(_v)); break;
        case 1: setOpacityMask(*reinterpret_cast< QBrush*>(_v)); break;
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

// SIGNAL 0
void QGraphicsOpacityEffect::opacityChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QGraphicsOpacityEffect::opacityMaskChanged(const QBrush & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
