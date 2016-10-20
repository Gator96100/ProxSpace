/****************************************************************************
** Meta object code from reading C++ file 'qundostack_p.h'
**
** Created: Thu Feb 11 02:24:19 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../util/qundostack_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qundostack_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QUndoAction[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      18,   13,   12,   12, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_QUndoAction[] = {
    "QUndoAction\0\0text\0setPrefixedText(QString)\0"
};

const QMetaObject QUndoAction::staticMetaObject = {
    { &QAction::staticMetaObject, qt_meta_stringdata_QUndoAction,
      qt_meta_data_QUndoAction, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QUndoAction::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QUndoAction::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QUndoAction::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QUndoAction))
        return static_cast<void*>(const_cast< QUndoAction*>(this));
    return QAction::qt_metacast(_clname);
}

int QUndoAction::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAction::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: setPrefixedText((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
