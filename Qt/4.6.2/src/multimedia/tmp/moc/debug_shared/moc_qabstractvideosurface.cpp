/****************************************************************************
** Meta object code from reading C++ file 'qabstractvideosurface.h'
**
** Created: Thu Feb 11 03:01:08 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../video/qabstractvideosurface.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qabstractvideosurface.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QAbstractVideoSurface[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      30,   23,   22,   22, 0x05,
      57,   50,   22,   22, 0x05,
      99,   22,   22,   22, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QAbstractVideoSurface[] = {
    "QAbstractVideoSurface\0\0active\0"
    "activeChanged(bool)\0format\0"
    "surfaceFormatChanged(QVideoSurfaceFormat)\0"
    "supportedFormatsChanged()\0"
};

const QMetaObject QAbstractVideoSurface::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAbstractVideoSurface,
      qt_meta_data_QAbstractVideoSurface, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAbstractVideoSurface::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAbstractVideoSurface::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAbstractVideoSurface::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAbstractVideoSurface))
        return static_cast<void*>(const_cast< QAbstractVideoSurface*>(this));
    return QObject::qt_metacast(_clname);
}

int QAbstractVideoSurface::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: activeChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: surfaceFormatChanged((*reinterpret_cast< const QVideoSurfaceFormat(*)>(_a[1]))); break;
        case 2: supportedFormatsChanged(); break;
        default: ;
        }
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void QAbstractVideoSurface::activeChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QAbstractVideoSurface::surfaceFormatChanged(const QVideoSurfaceFormat & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QAbstractVideoSurface::supportedFormatsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
QT_END_MOC_NAMESPACE
