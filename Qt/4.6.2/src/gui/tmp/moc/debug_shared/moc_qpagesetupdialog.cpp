/****************************************************************************
** Meta object code from reading C++ file 'qpagesetupdialog.h'
**
** Created: Thu Feb 11 02:23:50 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../dialogs/qpagesetupdialog.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qpagesetupdialog.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QPageSetupDialog[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       1,   14, // properties
       1,   17, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // properties: name, type, flags
      40,   17, 0x0009510b,

 // enums: name, flags, count, data
      48, 0x0,    3,   21,

 // enum data: key, value
      70, uint(QPageSetupDialog::None),
      75, uint(QPageSetupDialog::DontUseSheet),
      88, uint(QPageSetupDialog::OwnsPrinter),

       0        // eod
};

static const char qt_meta_stringdata_QPageSetupDialog[] = {
    "QPageSetupDialog\0PageSetupDialogOptions\0"
    "options\0PageSetupDialogOption\0None\0"
    "DontUseSheet\0OwnsPrinter\0"
};

const QMetaObject QPageSetupDialog::staticMetaObject = {
    { &QAbstractPageSetupDialog::staticMetaObject, qt_meta_stringdata_QPageSetupDialog,
      qt_meta_data_QPageSetupDialog, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QPageSetupDialog::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QPageSetupDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QPageSetupDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QPageSetupDialog))
        return static_cast<void*>(const_cast< QPageSetupDialog*>(this));
    return QAbstractPageSetupDialog::qt_metacast(_clname);
}

int QPageSetupDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractPageSetupDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
     if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< PageSetupDialogOptions*>(_v) = options(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setOptions(*reinterpret_cast< PageSetupDialogOptions*>(_v)); break;
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
QT_END_MOC_NAMESPACE
