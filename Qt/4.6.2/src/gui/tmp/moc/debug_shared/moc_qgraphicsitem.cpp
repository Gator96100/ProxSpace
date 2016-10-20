/****************************************************************************
** Meta object code from reading C++ file 'qgraphicsitem.h'
**
** Created: Thu Feb 11 02:21:13 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../graphicsview/qgraphicsitem.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qgraphicsitem.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QGraphicsObject[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
      11,   59, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       9,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   16,   16,   16, 0x05,
      33,   16,   16,   16, 0x05,
      50,   16,   16,   16, 0x05,
      67,   16,   16,   16, 0x05,
      84,   16,   16,   16, 0x05,
      95,   16,   16,   16, 0x05,
     106,   16,   16,   16, 0x05,
     117,   16,   16,   16, 0x05,
     135,   16,   16,   16, 0x05,

 // properties: name, type, flags
     167,  150, 0x0049400b,
     180,  174, (QMetaType::QReal << 24) | 0x00495903,
     193,  188, 0x01495103,
     201,  188, 0x01495903,
     217,  209, 0x1a095103,
     221,  174, (QMetaType::QReal << 24) | 0x00495103,
     223,  174, (QMetaType::QReal << 24) | 0x00495103,
     225,  174, (QMetaType::QReal << 24) | 0x00495003,
     227,  174, (QMetaType::QReal << 24) | 0x00495103,
     236,  174, (QMetaType::QReal << 24) | 0x00495103,
     242,  209, 0x1a095103,

 // properties: notify_signal_id
       0,
       1,
       3,
       2,
       0,
       4,
       5,
       6,
       7,
       8,
       0,

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsObject[] = {
    "QGraphicsObject\0\0parentChanged()\0"
    "opacityChanged()\0visibleChanged()\0"
    "enabledChanged()\0xChanged()\0yChanged()\0"
    "zChanged()\0rotationChanged()\0"
    "scaleChanged()\0QGraphicsObject*\0parent\0"
    "qreal\0opacity\0bool\0enabled\0visible\0"
    "QPointF\0pos\0x\0y\0z\0rotation\0scale\0"
    "transformOriginPoint\0"
};

const QMetaObject QGraphicsObject::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QGraphicsObject,
      qt_meta_data_QGraphicsObject, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsObject::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsObject::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsObject::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsObject))
        return static_cast<void*>(const_cast< QGraphicsObject*>(this));
    if (!strcmp(_clname, "QGraphicsItem"))
        return static_cast< QGraphicsItem*>(const_cast< QGraphicsObject*>(this));
    if (!strcmp(_clname, "com.trolltech.Qt.QGraphicsItem"))
        return static_cast< QGraphicsItem*>(const_cast< QGraphicsObject*>(this));
    return QObject::qt_metacast(_clname);
}

int QGraphicsObject::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: parentChanged(); break;
        case 1: opacityChanged(); break;
        case 2: visibleChanged(); break;
        case 3: enabledChanged(); break;
        case 4: xChanged(); break;
        case 5: yChanged(); break;
        case 6: zChanged(); break;
        case 7: rotationChanged(); break;
        case 8: scaleChanged(); break;
        default: ;
        }
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QGraphicsObject**>(_v) = parentObject(); break;
        case 1: *reinterpret_cast< qreal*>(_v) = opacity(); break;
        case 2: *reinterpret_cast< bool*>(_v) = isEnabled(); break;
        case 3: *reinterpret_cast< bool*>(_v) = isVisible(); break;
        case 4: *reinterpret_cast< QPointF*>(_v) = pos(); break;
        case 5: *reinterpret_cast< qreal*>(_v) = x(); break;
        case 6: *reinterpret_cast< qreal*>(_v) = y(); break;
        case 7: *reinterpret_cast< qreal*>(_v) = zValue(); break;
        case 8: *reinterpret_cast< qreal*>(_v) = rotation(); break;
        case 9: *reinterpret_cast< qreal*>(_v) = scale(); break;
        case 10: *reinterpret_cast< QPointF*>(_v) = transformOriginPoint(); break;
        }
        _id -= 11;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setParentItem(*reinterpret_cast< QGraphicsObject**>(_v)); break;
        case 1: setOpacity(*reinterpret_cast< qreal*>(_v)); break;
        case 2: setEnabled(*reinterpret_cast< bool*>(_v)); break;
        case 3: setVisible(*reinterpret_cast< bool*>(_v)); break;
        case 4: setPos(*reinterpret_cast< QPointF*>(_v)); break;
        case 5: setX(*reinterpret_cast< qreal*>(_v)); break;
        case 6: setY(*reinterpret_cast< qreal*>(_v)); break;
        case 7: setZValue(*reinterpret_cast< qreal*>(_v)); break;
        case 8: setRotation(*reinterpret_cast< qreal*>(_v)); break;
        case 9: setScale(*reinterpret_cast< qreal*>(_v)); break;
        case 10: setTransformOriginPoint(*reinterpret_cast< QPointF*>(_v)); break;
        }
        _id -= 11;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 11;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QGraphicsObject::parentChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QGraphicsObject::opacityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void QGraphicsObject::visibleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void QGraphicsObject::enabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void QGraphicsObject::xChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void QGraphicsObject::yChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void QGraphicsObject::zChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void QGraphicsObject::rotationChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, 0);
}

// SIGNAL 8
void QGraphicsObject::scaleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, 0);
}
static const uint qt_meta_data_QGraphicsTextItem[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      19,   18,   18,   18, 0x05,
      42,   18,   18,   18, 0x05,

 // slots: signature, parameters, type, tag, flags
      63,   18,   18,   18, 0x08,
      93,   18,   18,   18, 0x08,
     111,   18,   18,   18, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsTextItem[] = {
    "QGraphicsTextItem\0\0linkActivated(QString)\0"
    "linkHovered(QString)\0_q_updateBoundingRect(QSizeF)\0"
    "_q_update(QRectF)\0_q_ensureVisible(QRectF)\0"
};

const QMetaObject QGraphicsTextItem::staticMetaObject = {
    { &QGraphicsObject::staticMetaObject, qt_meta_stringdata_QGraphicsTextItem,
      qt_meta_data_QGraphicsTextItem, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsTextItem::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsTextItem::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsTextItem::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsTextItem))
        return static_cast<void*>(const_cast< QGraphicsTextItem*>(this));
    return QGraphicsObject::qt_metacast(_clname);
}

int QGraphicsTextItem::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGraphicsObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: linkActivated((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: linkHovered((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: dd->_q_updateBoundingRect((*reinterpret_cast< const QSizeF(*)>(_a[1]))); break;
        case 3: dd->_q_update((*reinterpret_cast< QRectF(*)>(_a[1]))); break;
        case 4: dd->_q_ensureVisible((*reinterpret_cast< QRectF(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void QGraphicsTextItem::linkActivated(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QGraphicsTextItem::linkHovered(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
