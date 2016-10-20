/****************************************************************************
** Meta object code from reading C++ file 'audiooutput.h'
**
** Created: Thu Feb 11 04:48:44 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../../3rdparty/phonon/ds9/audiooutput.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'audiooutput.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__DS9__AudioOutput[] = {

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
      36,   26,   25,   25, 0x05,
      57,   25,   25,   25, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__DS9__AudioOutput[] = {
    "Phonon::DS9::AudioOutput\0\0newVolume\0"
    "volumeChanged(qreal)\0audioDeviceFailed()\0"
};

const QMetaObject Phonon::DS9::AudioOutput::staticMetaObject = {
    { &BackendNode::staticMetaObject, qt_meta_stringdata_Phonon__DS9__AudioOutput,
      qt_meta_data_Phonon__DS9__AudioOutput, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::DS9::AudioOutput::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::DS9::AudioOutput::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::DS9::AudioOutput::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__DS9__AudioOutput))
        return static_cast<void*>(const_cast< AudioOutput*>(this));
    if (!strcmp(_clname, "Phonon::AudioOutputInterface"))
        return static_cast< Phonon::AudioOutputInterface*>(const_cast< AudioOutput*>(this));
    if (!strcmp(_clname, "AudioOutputInterface2.phonon.kde.org"))
        return static_cast< Phonon::AudioOutputInterface*>(const_cast< AudioOutput*>(this));
    return BackendNode::qt_metacast(_clname);
}

int Phonon::DS9::AudioOutput::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = BackendNode::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: volumeChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 1: audioDeviceFailed(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void Phonon::DS9::AudioOutput::volumeChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Phonon::DS9::AudioOutput::audioDeviceFailed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
