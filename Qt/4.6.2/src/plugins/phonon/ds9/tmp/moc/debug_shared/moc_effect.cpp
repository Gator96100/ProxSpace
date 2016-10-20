/****************************************************************************
** Meta object code from reading C++ file 'effect.h'
**
** Created: Thu Feb 11 04:48:49 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../../3rdparty/phonon/ds9/effect.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'effect.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__DS9__Effect[] = {

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

static const char qt_meta_stringdata_Phonon__DS9__Effect[] = {
    "Phonon::DS9::Effect\0"
};

const QMetaObject Phonon::DS9::Effect::staticMetaObject = {
    { &BackendNode::staticMetaObject, qt_meta_stringdata_Phonon__DS9__Effect,
      qt_meta_data_Phonon__DS9__Effect, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::DS9::Effect::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::DS9::Effect::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::DS9::Effect::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__DS9__Effect))
        return static_cast<void*>(const_cast< Effect*>(this));
    if (!strcmp(_clname, "Phonon::EffectInterface"))
        return static_cast< Phonon::EffectInterface*>(const_cast< Effect*>(this));
    if (!strcmp(_clname, "EffectInterface0.phonon.kde.org"))
        return static_cast< Phonon::EffectInterface*>(const_cast< Effect*>(this));
    return BackendNode::qt_metacast(_clname);
}

int Phonon::DS9::Effect::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = BackendNode::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
QT_END_MOC_NAMESPACE
