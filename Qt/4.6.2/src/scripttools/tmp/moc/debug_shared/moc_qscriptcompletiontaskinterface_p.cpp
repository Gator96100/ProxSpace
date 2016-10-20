/****************************************************************************
** Meta object code from reading C++ file 'qscriptcompletiontaskinterface_p.h'
**
** Created: Thu Feb 11 04:43:03 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../debugging/qscriptcompletiontaskinterface_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qscriptcompletiontaskinterface_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QScriptCompletionTaskInterface[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      32,   31,   31,   31, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QScriptCompletionTaskInterface[] = {
    "QScriptCompletionTaskInterface\0\0"
    "finished()\0"
};

const QMetaObject QScriptCompletionTaskInterface::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QScriptCompletionTaskInterface,
      qt_meta_data_QScriptCompletionTaskInterface, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QScriptCompletionTaskInterface::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QScriptCompletionTaskInterface::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QScriptCompletionTaskInterface::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QScriptCompletionTaskInterface))
        return static_cast<void*>(const_cast< QScriptCompletionTaskInterface*>(this));
    return QObject::qt_metacast(_clname);
}

int QScriptCompletionTaskInterface::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: finished(); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void QScriptCompletionTaskInterface::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
