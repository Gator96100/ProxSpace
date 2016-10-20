/****************************************************************************
** Meta object code from reading C++ file 'qparallelanimationgroup.h'
**
** Created: Thu Feb 11 02:02:43 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../animation/qparallelanimationgroup.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qparallelanimationgroup.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QParallelAnimationGroup[] = {

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
      25,   24,   24,   24, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QParallelAnimationGroup[] = {
    "QParallelAnimationGroup\0\0"
    "_q_uncontrolledAnimationFinished()\0"
};

const QMetaObject QParallelAnimationGroup::staticMetaObject = {
    { &QAnimationGroup::staticMetaObject, qt_meta_stringdata_QParallelAnimationGroup,
      qt_meta_data_QParallelAnimationGroup, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QParallelAnimationGroup::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QParallelAnimationGroup::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QParallelAnimationGroup::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QParallelAnimationGroup))
        return static_cast<void*>(const_cast< QParallelAnimationGroup*>(this));
    return QAnimationGroup::qt_metacast(_clname);
}

int QParallelAnimationGroup::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAnimationGroup::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: d_func()->_q_uncontrolledAnimationFinished(); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
