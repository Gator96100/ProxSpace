/****************************************************************************
** Meta object code from reading C++ file 'qfilesystemwatcher_win_p.h'
**
** Created: Thu Feb 11 02:05:10 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../io/qfilesystemwatcher_win_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qfilesystemwatcher_win_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QWindowsFileSystemWatcherEngine[] = {

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

static const char qt_meta_stringdata_QWindowsFileSystemWatcherEngine[] = {
    "QWindowsFileSystemWatcherEngine\0"
};

const QMetaObject QWindowsFileSystemWatcherEngine::staticMetaObject = {
    { &QFileSystemWatcherEngine::staticMetaObject, qt_meta_stringdata_QWindowsFileSystemWatcherEngine,
      qt_meta_data_QWindowsFileSystemWatcherEngine, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QWindowsFileSystemWatcherEngine::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QWindowsFileSystemWatcherEngine::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QWindowsFileSystemWatcherEngine::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QWindowsFileSystemWatcherEngine))
        return static_cast<void*>(const_cast< QWindowsFileSystemWatcherEngine*>(this));
    return QFileSystemWatcherEngine::qt_metacast(_clname);
}

int QWindowsFileSystemWatcherEngine::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QFileSystemWatcherEngine::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
static const uint qt_meta_data_QWindowsFileSystemWatcherEngineThread[] = {

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
      52,   39,   38,   38, 0x05,
      78,   39,   38,   38, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QWindowsFileSystemWatcherEngineThread[] = {
    "QWindowsFileSystemWatcherEngineThread\0"
    "\0path,removed\0fileChanged(QString,bool)\0"
    "directoryChanged(QString,bool)\0"
};

const QMetaObject QWindowsFileSystemWatcherEngineThread::staticMetaObject = {
    { &QThread::staticMetaObject, qt_meta_stringdata_QWindowsFileSystemWatcherEngineThread,
      qt_meta_data_QWindowsFileSystemWatcherEngineThread, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QWindowsFileSystemWatcherEngineThread::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QWindowsFileSystemWatcherEngineThread::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QWindowsFileSystemWatcherEngineThread::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QWindowsFileSystemWatcherEngineThread))
        return static_cast<void*>(const_cast< QWindowsFileSystemWatcherEngineThread*>(this));
    return QThread::qt_metacast(_clname);
}

int QWindowsFileSystemWatcherEngineThread::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QThread::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: fileChanged((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 1: directoryChanged((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void QWindowsFileSystemWatcherEngineThread::fileChanged(const QString & _t1, bool _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QWindowsFileSystemWatcherEngineThread::directoryChanged(const QString & _t1, bool _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
