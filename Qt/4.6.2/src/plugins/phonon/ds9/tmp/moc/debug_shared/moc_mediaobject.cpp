/****************************************************************************
** Meta object code from reading C++ file 'mediaobject.h'
**
** Created: Thu Feb 11 04:48:56 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../../3rdparty/phonon/ds9/mediaobject.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mediaobject.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__DS9__WorkerThread[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      30,   27,   26,   26, 0x05,
      75,   73,   26,   26, 0x05,
     112,   73,   26,   26, 0x05,
     162,  144,   26,   26, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__DS9__WorkerThread[] = {
    "Phonon::DS9::WorkerThread\0\0,,\0"
    "asyncRenderFinished(quint16,HRESULT,Graph)\0"
    ",\0asyncSeekingFinished(quint16,qint64)\0"
    "stateReady(Graph,Phonon::State)\0"
    ",eventCode,param1\0eventReady(Graph,long,long)\0"
};

const QMetaObject Phonon::DS9::WorkerThread::staticMetaObject = {
    { &QThread::staticMetaObject, qt_meta_stringdata_Phonon__DS9__WorkerThread,
      qt_meta_data_Phonon__DS9__WorkerThread, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::DS9::WorkerThread::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::DS9::WorkerThread::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::DS9::WorkerThread::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__DS9__WorkerThread))
        return static_cast<void*>(const_cast< WorkerThread*>(this));
    return QThread::qt_metacast(_clname);
}

int Phonon::DS9::WorkerThread::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QThread::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: asyncRenderFinished((*reinterpret_cast< quint16(*)>(_a[1])),(*reinterpret_cast< HRESULT(*)>(_a[2])),(*reinterpret_cast< Graph(*)>(_a[3]))); break;
        case 1: asyncSeekingFinished((*reinterpret_cast< quint16(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 2: stateReady((*reinterpret_cast< Graph(*)>(_a[1])),(*reinterpret_cast< Phonon::State(*)>(_a[2]))); break;
        case 3: eventReady((*reinterpret_cast< Graph(*)>(_a[1])),(*reinterpret_cast< long(*)>(_a[2])),(*reinterpret_cast< long(*)>(_a[3]))); break;
        default: ;
        }
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void Phonon::DS9::WorkerThread::asyncRenderFinished(quint16 _t1, HRESULT _t2, Graph _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Phonon::DS9::WorkerThread::asyncSeekingFinished(quint16 _t1, qint64 _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Phonon::DS9::WorkerThread::stateReady(Graph _t1, Phonon::State _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Phonon::DS9::WorkerThread::eventReady(Graph _t1, long _t2, long _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
static const uint qt_meta_data_Phonon__DS9__MediaObject[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      22,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      17,       // signalCount

 // signals: signature, parameters, type, tag, flags
      44,   26,   25,   25, 0x05,
      91,   86,   25,   25, 0x05,
     104,   25,   25,   25, 0x05,
     148,   25,   25,   25, 0x05,
     170,   25,   25,   25, 0x05,
     192,   25,   25,   25, 0x05,
     210,   25,   25,   25, 0x05,
     228,   25,   25,   25, 0x05,
     256,   25,   25,   25, 0x05,
     276,   25,   25,   25, 0x05,
     306,   25,   25,   25, 0x05,
     324,   25,   25,   25, 0x05,
     352,   25,   25,   25, 0x05,
     363,   25,   25,   25, 0x05,
     392,   25,   25,   25, 0x05,
     415,  408,   25,   25, 0x05,
     440,   25,   25,   25, 0x05,

 // slots: signature, parameters, type, tag, flags
     474,   25,   25,   25, 0x08,
     497,  495,   25,   25, 0x08,
     551,  533,   25,   25, 0x08,
     592,  581,   25,   25, 0x08,
     641,  629,   25,   25, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_Phonon__DS9__MediaObject[] = {
    "Phonon::DS9::MediaObject\0\0newstate,oldstate\0"
    "stateChanged(Phonon::State,Phonon::State)\0"
    "time\0tick(qint64)\0"
    "metaDataChanged(QMultiMap<QString,QString>)\0"
    "seekableChanged(bool)\0hasVideoChanged(bool)\0"
    "bufferStatus(int)\0titleChanged(int)\0"
    "availableTitlesChanged(int)\0"
    "chapterChanged(int)\0availableChaptersChanged(int)\0"
    "angleChanged(int)\0availableAnglesChanged(int)\0"
    "finished()\0prefinishMarkReached(qint32)\0"
    "aboutToFinish()\0length\0totalTimeChanged(qint64)\0"
    "currentSourceChanged(MediaSource)\0"
    "switchToNextSource()\0,\0"
    "slotStateReady(Graph,Phonon::State)\0"
    ",eventCode,param1\0handleEvents(Graph,long,long)\0"
    "workId,hr,\0finishLoading(quint16,HRESULT,Graph)\0"
    "workId,time\0finishSeeking(quint16,qint64)\0"
};

const QMetaObject Phonon::DS9::MediaObject::staticMetaObject = {
    { &BackendNode::staticMetaObject, qt_meta_stringdata_Phonon__DS9__MediaObject,
      qt_meta_data_Phonon__DS9__MediaObject, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::DS9::MediaObject::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::DS9::MediaObject::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::DS9::MediaObject::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__DS9__MediaObject))
        return static_cast<void*>(const_cast< MediaObject*>(this));
    if (!strcmp(_clname, "Phonon::MediaObjectInterface"))
        return static_cast< Phonon::MediaObjectInterface*>(const_cast< MediaObject*>(this));
    if (!strcmp(_clname, "Phonon::AddonInterface"))
        return static_cast< Phonon::AddonInterface*>(const_cast< MediaObject*>(this));
    if (!strcmp(_clname, "MediaObjectInterface3.phonon.kde.org"))
        return static_cast< Phonon::MediaObjectInterface*>(const_cast< MediaObject*>(this));
    if (!strcmp(_clname, "AddonInterface0.2.phonon.kde.org"))
        return static_cast< Phonon::AddonInterface*>(const_cast< MediaObject*>(this));
    return BackendNode::qt_metacast(_clname);
}

int Phonon::DS9::MediaObject::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = BackendNode::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: stateChanged((*reinterpret_cast< Phonon::State(*)>(_a[1])),(*reinterpret_cast< Phonon::State(*)>(_a[2]))); break;
        case 1: tick((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 2: metaDataChanged((*reinterpret_cast< QMultiMap<QString,QString>(*)>(_a[1]))); break;
        case 3: seekableChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 4: hasVideoChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 5: bufferStatus((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: titleChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: availableTitlesChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: chapterChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: availableChaptersChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 10: angleChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: availableAnglesChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 12: finished(); break;
        case 13: prefinishMarkReached((*reinterpret_cast< qint32(*)>(_a[1]))); break;
        case 14: aboutToFinish(); break;
        case 15: totalTimeChanged((*reinterpret_cast< qint64(*)>(_a[1]))); break;
        case 16: currentSourceChanged((*reinterpret_cast< const MediaSource(*)>(_a[1]))); break;
        case 17: switchToNextSource(); break;
        case 18: slotStateReady((*reinterpret_cast< Graph(*)>(_a[1])),(*reinterpret_cast< Phonon::State(*)>(_a[2]))); break;
        case 19: handleEvents((*reinterpret_cast< Graph(*)>(_a[1])),(*reinterpret_cast< long(*)>(_a[2])),(*reinterpret_cast< long(*)>(_a[3]))); break;
        case 20: finishLoading((*reinterpret_cast< quint16(*)>(_a[1])),(*reinterpret_cast< HRESULT(*)>(_a[2])),(*reinterpret_cast< Graph(*)>(_a[3]))); break;
        case 21: finishSeeking((*reinterpret_cast< quint16(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 22;
    }
    return _id;
}

// SIGNAL 0
void Phonon::DS9::MediaObject::stateChanged(Phonon::State _t1, Phonon::State _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Phonon::DS9::MediaObject::tick(qint64 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Phonon::DS9::MediaObject::metaDataChanged(QMultiMap<QString,QString> _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Phonon::DS9::MediaObject::seekableChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void Phonon::DS9::MediaObject::hasVideoChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void Phonon::DS9::MediaObject::bufferStatus(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void Phonon::DS9::MediaObject::titleChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void Phonon::DS9::MediaObject::availableTitlesChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void Phonon::DS9::MediaObject::chapterChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void Phonon::DS9::MediaObject::availableChaptersChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void Phonon::DS9::MediaObject::angleChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void Phonon::DS9::MediaObject::availableAnglesChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}

// SIGNAL 12
void Phonon::DS9::MediaObject::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 12, 0);
}

// SIGNAL 13
void Phonon::DS9::MediaObject::prefinishMarkReached(qint32 _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 13, _a);
}

// SIGNAL 14
void Phonon::DS9::MediaObject::aboutToFinish()
{
    QMetaObject::activate(this, &staticMetaObject, 14, 0);
}

// SIGNAL 15
void Phonon::DS9::MediaObject::totalTimeChanged(qint64 _t1)const
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(const_cast< Phonon::DS9::MediaObject *>(this), &staticMetaObject, 15, _a);
}

// SIGNAL 16
void Phonon::DS9::MediaObject::currentSourceChanged(const MediaSource & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 16, _a);
}
QT_END_MOC_NAMESPACE
