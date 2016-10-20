/****************************************************************************
** Meta object code from reading C++ file 'qaudiooutput_win32_p.h'
**
** Created: Thu Feb 11 03:01:05 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../audio/qaudiooutput_win32_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qaudiooutput_win32_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QAudioOutputPrivate[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      21,   20,   20,   20, 0x08,
      37,   20,   32,   20, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QAudioOutputPrivate[] = {
    "QAudioOutputPrivate\0\0feedback()\0bool\0"
    "deviceReady()\0"
};

const QMetaObject QAudioOutputPrivate::staticMetaObject = {
    { &QAbstractAudioOutput::staticMetaObject, qt_meta_stringdata_QAudioOutputPrivate,
      qt_meta_data_QAudioOutputPrivate, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAudioOutputPrivate::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAudioOutputPrivate::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAudioOutputPrivate::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAudioOutputPrivate))
        return static_cast<void*>(const_cast< QAudioOutputPrivate*>(this));
    return QAbstractAudioOutput::qt_metacast(_clname);
}

int QAudioOutputPrivate::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractAudioOutput::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: feedback(); break;
        case 1: { bool _r = deviceReady();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}
static const uint qt_meta_data_OutputPrivate[] = {

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

static const char qt_meta_stringdata_OutputPrivate[] = {
    "OutputPrivate\0"
};

const QMetaObject OutputPrivate::staticMetaObject = {
    { &QIODevice::staticMetaObject, qt_meta_stringdata_OutputPrivate,
      qt_meta_data_OutputPrivate, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &OutputPrivate::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *OutputPrivate::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *OutputPrivate::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_OutputPrivate))
        return static_cast<void*>(const_cast< OutputPrivate*>(this));
    return QIODevice::qt_metacast(_clname);
}

int OutputPrivate::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QIODevice::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
QT_END_MOC_NAMESPACE
