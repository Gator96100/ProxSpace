/****************************************************************************
** Meta object code from reading C++ file 'qscriptdebuggerscriptswidgetinterface_p.h'
**
** Created: Thu Feb 11 04:43:10 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../debugging/qscriptdebuggerscriptswidgetinterface_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qscriptdebuggerscriptswidgetinterface_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QScriptDebuggerScriptsWidgetInterface[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      48,   39,   38,   38, 0x05,
      88,   77,   38,   38, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QScriptDebuggerScriptsWidgetInterface[] = {
    "QScriptDebuggerScriptsWidgetInterface\0"
    "\0scriptId\0currentScriptChanged(qint64)\0"
    "lineNumber\0scriptLocationSelected(int)\0"
};

const QMetaObject QScriptDebuggerScriptsWidgetInterface::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_QScriptDebuggerScriptsWidgetInterface,
      qt_meta_data_QScriptDebuggerScriptsWidgetInterface, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QScriptDebuggerScriptsWidgetInterface::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QScriptDebuggerScriptsWidgetInterface::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QScriptDebuggerScriptsWidgetInterface::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QScriptDebuggerScriptsWidgetInterface))
        return static_cast<void*>(const_cast< QScriptDebuggerScriptsWidgetInterface*>(this));
    return QWidget::qt_metacast(_clname);
}

int QScriptDebuggerScriptsWidgetInterface::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: currentScriptChanged((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 1: scriptLocationSelected((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void QScriptDebuggerScriptsWidgetInterface::currentScriptChanged(qint64 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QScriptDebuggerScriptsWidgetInterface::scriptLocationSelected(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
