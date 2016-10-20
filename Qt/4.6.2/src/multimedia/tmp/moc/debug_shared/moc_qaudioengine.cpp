/****************************************************************************
** Meta object code from reading C++ file 'qaudioengine.h'
**
** Created: Thu Feb 11 03:01:03 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../audio/qaudioengine.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qaudioengine.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QAbstractAudioDeviceInfo[] = {

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

static const char qt_meta_stringdata_QAbstractAudioDeviceInfo[] = {
    "QAbstractAudioDeviceInfo\0"
};

const QMetaObject QAbstractAudioDeviceInfo::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAbstractAudioDeviceInfo,
      qt_meta_data_QAbstractAudioDeviceInfo, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAbstractAudioDeviceInfo::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAbstractAudioDeviceInfo::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAbstractAudioDeviceInfo::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAbstractAudioDeviceInfo))
        return static_cast<void*>(const_cast< QAbstractAudioDeviceInfo*>(this));
    return QObject::qt_metacast(_clname);
}

int QAbstractAudioDeviceInfo::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
static const uint qt_meta_data_QAbstractAudioOutput[] = {

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
      22,   21,   21,   21, 0x05,
      50,   21,   21,   21, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QAbstractAudioOutput[] = {
    "QAbstractAudioOutput\0\0stateChanged(QAudio::State)\0"
    "notify()\0"
};

const QMetaObject QAbstractAudioOutput::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAbstractAudioOutput,
      qt_meta_data_QAbstractAudioOutput, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAbstractAudioOutput::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAbstractAudioOutput::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAbstractAudioOutput::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAbstractAudioOutput))
        return static_cast<void*>(const_cast< QAbstractAudioOutput*>(this));
    return QObject::qt_metacast(_clname);
}

int QAbstractAudioOutput::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: stateChanged((*reinterpret_cast< QAudio::State(*)>(_a[1]))); break;
        case 1: notify(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void QAbstractAudioOutput::stateChanged(QAudio::State _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QAbstractAudioOutput::notify()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
static const uint qt_meta_data_QAbstractAudioInput[] = {

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
      21,   20,   20,   20, 0x05,
      49,   20,   20,   20, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QAbstractAudioInput[] = {
    "QAbstractAudioInput\0\0stateChanged(QAudio::State)\0"
    "notify()\0"
};

const QMetaObject QAbstractAudioInput::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAbstractAudioInput,
      qt_meta_data_QAbstractAudioInput, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAbstractAudioInput::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAbstractAudioInput::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAbstractAudioInput::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAbstractAudioInput))
        return static_cast<void*>(const_cast< QAbstractAudioInput*>(this));
    return QObject::qt_metacast(_clname);
}

int QAbstractAudioInput::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: stateChanged((*reinterpret_cast< QAudio::State(*)>(_a[1]))); break;
        case 1: notify(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void QAbstractAudioInput::stateChanged(QAudio::State _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QAbstractAudioInput::notify()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
