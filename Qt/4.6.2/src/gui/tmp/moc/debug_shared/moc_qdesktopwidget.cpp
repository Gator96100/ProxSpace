/****************************************************************************
** Meta object code from reading C++ file 'qdesktopwidget.h'
**
** Created: Thu Feb 11 02:22:32 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../kernel/qdesktopwidget.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qdesktopwidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QDesktopWidget[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       3,   29, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      16,   15,   15,   15, 0x05,
      29,   15,   15,   15, 0x05,
      50,   15,   15,   15, 0x05,

 // properties: name, type, flags
      79,   74, 0x01095001,
      98,   94, 0x02495001,
     110,   94, 0x02095001,

 // properties: notify_signal_id
       0,
       2,
       0,

       0        // eod
};

static const char qt_meta_stringdata_QDesktopWidget[] = {
    "QDesktopWidget\0\0resized(int)\0"
    "workAreaResized(int)\0screenCountChanged(int)\0"
    "bool\0virtualDesktop\0int\0screenCount\0"
    "primaryScreen\0"
};

const QMetaObject QDesktopWidget::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_QDesktopWidget,
      qt_meta_data_QDesktopWidget, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QDesktopWidget::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QDesktopWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QDesktopWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QDesktopWidget))
        return static_cast<void*>(const_cast< QDesktopWidget*>(this));
    return QWidget::qt_metacast(_clname);
}

int QDesktopWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: resized((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: workAreaResized((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: screenCountChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = isVirtualDesktop(); break;
        case 1: *reinterpret_cast< int*>(_v) = screenCount(); break;
        case 2: *reinterpret_cast< int*>(_v) = primaryScreen(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
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

// SIGNAL 0
void QDesktopWidget::resized(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QDesktopWidget::workAreaResized(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QDesktopWidget::screenCountChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_END_MOC_NAMESPACE
