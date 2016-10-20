/****************************************************************************
** Meta object code from reading C++ file 'qscripterrorlogwidgetinterface_p.h'
**
** Created: Thu Feb 11 04:43:22 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../debugging/qscripterrorlogwidgetinterface_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qscripterrorlogwidgetinterface_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QScriptErrorLogWidgetInterface[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

       0        // eod
};

static const char qt_meta_stringdata_QScriptErrorLogWidgetInterface[] = {
    "QScriptErrorLogWidgetInterface\0"
};

const QMetaObject QScriptErrorLogWidgetInterface::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_QScriptErrorLogWidgetInterface,
      qt_meta_data_QScriptErrorLogWidgetInterface, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QScriptErrorLogWidgetInterface::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QScriptErrorLogWidgetInterface::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QScriptErrorLogWidgetInterface::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QScriptErrorLogWidgetInterface))
        return static_cast<void*>(const_cast< QScriptErrorLogWidgetInterface*>(this));
    if (!strcmp(_clname, "QScriptMessageHandlerInterface"))
        return static_cast< QScriptMessageHandlerInterface*>(const_cast< QScriptErrorLogWidgetInterface*>(this));
    return QWidget::qt_metacast(_clname);
}

int QScriptErrorLogWidgetInterface::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
QT_END_MOC_NAMESPACE
