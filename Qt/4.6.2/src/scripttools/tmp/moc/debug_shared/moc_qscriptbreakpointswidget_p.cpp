/****************************************************************************
** Meta object code from reading C++ file 'qscriptbreakpointswidget_p.h'
**
** Created: Thu Feb 11 04:42:51 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../debugging/qscriptbreakpointswidget_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qscriptbreakpointswidget_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QScriptBreakpointsWidget[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      26,   25,   25,   25, 0x08,
      45,   25,   25,   25, 0x08,
      67,   25,   25,   25, 0x08,
     102,  100,   25,   25, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QScriptBreakpointsWidget[] = {
    "QScriptBreakpointsWidget\0\0_q_newBreakpoint()\0"
    "_q_deleteBreakpoint()\0"
    "_q_onCurrentChanged(QModelIndex)\0,\0"
    "_q_onNewBreakpointRequest(QString,int)\0"
};

const QMetaObject QScriptBreakpointsWidget::staticMetaObject = {
    { &QScriptBreakpointsWidgetInterface::staticMetaObject, qt_meta_stringdata_QScriptBreakpointsWidget,
      qt_meta_data_QScriptBreakpointsWidget, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QScriptBreakpointsWidget::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QScriptBreakpointsWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QScriptBreakpointsWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QScriptBreakpointsWidget))
        return static_cast<void*>(const_cast< QScriptBreakpointsWidget*>(this));
    return QScriptBreakpointsWidgetInterface::qt_metacast(_clname);
}

int QScriptBreakpointsWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QScriptBreakpointsWidgetInterface::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: d_func()->_q_newBreakpoint(); break;
        case 1: d_func()->_q_deleteBreakpoint(); break;
        case 2: d_func()->_q_onCurrentChanged((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 3: d_func()->_q_onNewBreakpointRequest((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 4;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
