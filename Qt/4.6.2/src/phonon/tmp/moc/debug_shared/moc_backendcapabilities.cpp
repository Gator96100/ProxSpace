/****************************************************************************
** Meta object code from reading C++ file 'backendcapabilities.h'
**
** Created: Thu Feb 11 02:59:48 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/backendcapabilities.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'backendcapabilities.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__BackendCapabilities__Notifier[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      39,   38,   38,   38, 0x05,
      61,   38,   38,   38, 0x05,
      98,   38,   38,   38, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__BackendCapabilities__Notifier[] = {
    "Phonon::BackendCapabilities::Notifier\0"
    "\0capabilitiesChanged()\0"
    "availableAudioOutputDevicesChanged()\0"
    "availableAudioCaptureDevicesChanged()\0"
};

const QMetaObject Phonon::BackendCapabilities::Notifier::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Phonon__BackendCapabilities__Notifier,
      qt_meta_data_Phonon__BackendCapabilities__Notifier, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::BackendCapabilities::Notifier::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::BackendCapabilities::Notifier::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::BackendCapabilities::Notifier::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__BackendCapabilities__Notifier))
        return static_cast<void*>(const_cast< Notifier*>(this));
    return QObject::qt_metacast(_clname);
}

int Phonon::BackendCapabilities::Notifier::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: capabilitiesChanged(); break;
        case 1: availableAudioOutputDevicesChanged(); break;
        case 2: availableAudioCaptureDevicesChanged(); break;
        default: ;
        }
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void Phonon::BackendCapabilities::Notifier::capabilitiesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void Phonon::BackendCapabilities::Notifier::availableAudioOutputDevicesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void Phonon::BackendCapabilities::Notifier::availableAudioCaptureDevicesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
QT_END_MOC_NAMESPACE
