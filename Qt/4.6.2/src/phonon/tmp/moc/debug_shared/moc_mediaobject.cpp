/****************************************************************************
** Meta object code from reading C++ file 'mediaobject.h'
**
** Created: Thu Feb 11 02:59:32 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/mediaobject.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mediaobject.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__MediaObject[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      23,   14, // methods
       3,  129, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      11,       // signalCount

 // signals: signature, parameters, type, tag, flags
      39,   21,   20,   20, 0x05,
      86,   81,   20,   20, 0x05,
      99,   20,   20,   20, 0x05,
     128,  117,   20,   20, 0x05,
     159,  150,   20,   20, 0x05,
     195,  181,   20,   20, 0x05,
     213,   20,   20,   20, 0x05,
     234,  224,   20,   20, 0x05,
     276,   20,   20,   20, 0x05,
     302,  292,   20,   20, 0x05,
     344,  331,   20,   20, 0x05,

 // slots: signature, parameters, type, tag, flags
     385,  369,   20,   20, 0x0a,
     409,   20,   20,   20, 0x0a,
     416,   20,   20,   20, 0x0a,
     424,   20,   20,   20, 0x0a,
     431,   81,   20,   20, 0x0a,
     444,   20,   20,   20, 0x0a,
     452,   20,   20,   20, 0x08,
     468,   20,   20,   20, 0x08,
     485,   20,   20,   20, 0x08,
     534,  532,   20,   20, 0x08,
     579,   20,   20,   20, 0x08,
     598,   20,   20,   20, 0x08,

 // properties: name, type, flags
     642,  635, 0x02095103,
     657,  635, 0x02095103,
     671,  635, 0x02095103,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__MediaObject[] = {
    "Phonon::MediaObject\0\0newstate,oldstate\0"
    "stateChanged(Phonon::State,Phonon::State)\0"
    "time\0tick(qint64)\0metaDataChanged()\0"
    "isSeekable\0seekableChanged(bool)\0"
    "hasVideo\0hasVideoChanged(bool)\0"
    "percentFilled\0bufferStatus(int)\0"
    "finished()\0newSource\0"
    "currentSourceChanged(Phonon::MediaSource)\0"
    "aboutToFinish()\0msecToEnd\0"
    "prefinishMarkReached(qint32)\0newTotalTime\0"
    "totalTimeChanged(qint64)\0newTickInterval\0"
    "setTickInterval(qint32)\0play()\0pause()\0"
    "stop()\0seek(qint64)\0clear()\0_k_resumePlay()\0"
    "_k_resumePause()\0"
    "_k_metaDataChanged(QMultiMap<QString,QString>)\0"
    ",\0_k_stateChanged(Phonon::State,Phonon::State)\0"
    "_k_aboutToFinish()\0"
    "_k_currentSourceChanged(MediaSource)\0"
    "qint32\0transitionTime\0prefinishMark\0"
    "tickInterval\0"
};

const QMetaObject Phonon::MediaObject::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Phonon__MediaObject,
      qt_meta_data_Phonon__MediaObject, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::MediaObject::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::MediaObject::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::MediaObject::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__MediaObject))
        return static_cast<void*>(const_cast< MediaObject*>(this));
    if (!strcmp(_clname, "MediaNode"))
        return static_cast< MediaNode*>(const_cast< MediaObject*>(this));
    return QObject::qt_metacast(_clname);
}

int Phonon::MediaObject::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: stateChanged((*reinterpret_cast< Phonon::State(*)>(_a[1])),(*reinterpret_cast< Phonon::State(*)>(_a[2]))); break;
        case 1: tick((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 2: metaDataChanged(); break;
        case 3: seekableChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 4: hasVideoChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 5: bufferStatus((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: finished(); break;
        case 7: currentSourceChanged((*reinterpret_cast< const Phonon::MediaSource(*)>(_a[1]))); break;
        case 8: aboutToFinish(); break;
        case 9: prefinishMarkReached((*reinterpret_cast< qint32(*)>(_a[1]))); break;
        case 10: totalTimeChanged((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 11: setTickInterval((*reinterpret_cast< qint32(*)>(_a[1]))); break;
        case 12: play(); break;
        case 13: pause(); break;
        case 14: stop(); break;
        case 15: seek((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 16: clear(); break;
        case 17: k_func()->_k_resumePlay(); break;
        case 18: k_func()->_k_resumePause(); break;
        case 19: k_func()->_k_metaDataChanged((*reinterpret_cast< const QMultiMap<QString,QString>(*)>(_a[1]))); break;
        case 20: k_func()->_k_stateChanged((*reinterpret_cast< Phonon::State(*)>(_a[1])),(*reinterpret_cast< Phonon::State(*)>(_a[2]))); break;
        case 21: k_func()->_k_aboutToFinish(); break;
        case 22: k_func()->_k_currentSourceChanged((*reinterpret_cast< const MediaSource(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 23;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< qint32*>(_v) = transitionTime(); break;
        case 1: *reinterpret_cast< qint32*>(_v) = prefinishMark(); break;
        case 2: *reinterpret_cast< qint32*>(_v) = tickInterval(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setTransitionTime(*reinterpret_cast< qint32*>(_v)); break;
        case 1: setPrefinishMark(*reinterpret_cast< qint32*>(_v)); break;
        case 2: setTickInterval(*reinterpret_cast< qint32*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Phonon::MediaObject::stateChanged(Phonon::State _t1, Phonon::State _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Phonon::MediaObject::tick(qint64 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Phonon::MediaObject::metaDataChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void Phonon::MediaObject::seekableChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void Phonon::MediaObject::hasVideoChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void Phonon::MediaObject::bufferStatus(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void Phonon::MediaObject::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void Phonon::MediaObject::currentSourceChanged(const Phonon::MediaSource & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void Phonon::MediaObject::aboutToFinish()
{
    QMetaObject::activate(this, &staticMetaObject, 8, 0);
}

// SIGNAL 9
void Phonon::MediaObject::prefinishMarkReached(qint32 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void Phonon::MediaObject::totalTimeChanged(qint64 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}
QT_END_MOC_NAMESPACE
