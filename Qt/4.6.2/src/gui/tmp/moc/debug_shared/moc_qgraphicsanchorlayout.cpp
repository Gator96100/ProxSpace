/****************************************************************************
** Meta object code from reading C++ file 'qgraphicsanchorlayout.h'
**
** Created: Thu Feb 11 02:24:14 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../graphicsview/qgraphicsanchorlayout.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qgraphicsanchorlayout.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QGraphicsAnchor[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       2,   14, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // properties: name, type, flags
      22,   16, (QMetaType::QReal << 24) | 0x00095107,
      50,   30, 0x0009510b,

       0        // eod
};

static const char qt_meta_stringdata_QGraphicsAnchor[] = {
    "QGraphicsAnchor\0qreal\0spacing\0"
    "QSizePolicy::Policy\0sizePolicy\0"
};

#ifdef Q_NO_DATA_RELOCATION
static const QMetaObjectAccessor qt_meta_extradata_QGraphicsAnchor[] = {
        QSizePolicy::getStaticMetaObject,
#else
static const QMetaObject *qt_meta_extradata_QGraphicsAnchor[] = {
        &QSizePolicy::staticMetaObject,
#endif //Q_NO_DATA_RELOCATION
    0
};

static const QMetaObjectExtraData qt_meta_extradata2_QGraphicsAnchor = {
    qt_meta_extradata_QGraphicsAnchor, 0 
};

const QMetaObject QGraphicsAnchor::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QGraphicsAnchor,
      qt_meta_data_QGraphicsAnchor, &qt_meta_extradata2_QGraphicsAnchor }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGraphicsAnchor::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGraphicsAnchor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGraphicsAnchor::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGraphicsAnchor))
        return static_cast<void*>(const_cast< QGraphicsAnchor*>(this));
    return QObject::qt_metacast(_clname);
}

int QGraphicsAnchor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
     if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< qreal*>(_v) = spacing(); break;
        case 1: *reinterpret_cast< QSizePolicy::Policy*>(_v) = sizePolicy(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setSpacing(*reinterpret_cast< qreal*>(_v)); break;
        case 1: setSizePolicy(*reinterpret_cast< QSizePolicy::Policy*>(_v)); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        switch (_id) {
        case 0: unsetSpacing(); break;
        }
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
