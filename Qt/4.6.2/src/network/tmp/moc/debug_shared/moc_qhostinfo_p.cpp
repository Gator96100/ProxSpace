/****************************************************************************
** Meta object code from reading C++ file 'qhostinfo_p.h'
**
** Created: Thu Feb 11 02:09:38 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../kernel/qhostinfo_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qhostinfo_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QHostInfoResult[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      22,   17,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
      46,   17,   16,   16, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_QHostInfoResult[] = {
    "QHostInfoResult\0\0info\0resultsReady(QHostInfo)\0"
    "emitResultsReady(QHostInfo)\0"
};

const QMetaObject QHostInfoResult::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QHostInfoResult,
      qt_meta_data_QHostInfoResult, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QHostInfoResult::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QHostInfoResult::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QHostInfoResult::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QHostInfoResult))
        return static_cast<void*>(const_cast< QHostInfoResult*>(this));
    return QObject::qt_metacast(_clname);
}

int QHostInfoResult::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: resultsReady((*reinterpret_cast< const QHostInfo(*)>(_a[1]))); break;
        case 1: emitResultsReady((*reinterpret_cast< const QHostInfo(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void QHostInfoResult::resultsReady(const QHostInfo _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
static const uint qt_meta_data_QHostInfoAgent[] = {

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

static const char qt_meta_stringdata_QHostInfoAgent[] = {
    "QHostInfoAgent\0"
};

const QMetaObject QHostInfoAgent::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QHostInfoAgent,
      qt_meta_data_QHostInfoAgent, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QHostInfoAgent::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QHostInfoAgent::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QHostInfoAgent::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QHostInfoAgent))
        return static_cast<void*>(const_cast< QHostInfoAgent*>(this));
    return QObject::qt_metacast(_clname);
}

int QHostInfoAgent::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
static const uint qt_meta_data_QHostInfoLookupManager[] = {

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

static const char qt_meta_stringdata_QHostInfoLookupManager[] = {
    "QHostInfoLookupManager\0"
};

const QMetaObject QHostInfoLookupManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QHostInfoLookupManager,
      qt_meta_data_QHostInfoLookupManager, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QHostInfoLookupManager::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QHostInfoLookupManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QHostInfoLookupManager::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QHostInfoLookupManager))
        return static_cast<void*>(const_cast< QHostInfoLookupManager*>(this));
    return QObject::qt_metacast(_clname);
}

int QHostInfoLookupManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
QT_END_MOC_NAMESPACE
