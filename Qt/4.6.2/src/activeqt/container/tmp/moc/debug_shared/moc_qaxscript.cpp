/****************************************************************************
** Meta object code from reading C++ file 'qaxscript.h'
**
** Created: Thu Feb 11 02:42:59 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../qaxscript.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qaxscript.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QAxScript[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: signature, parameters, type, tag, flags
      11,   10,   10,   10, 0x05,
      21,   10,   10,   10, 0x05,
      39,   32,   10,   10, 0x05,
      87,   58,   10,   10, 0x05,
     131,  125,   10,   10, 0x05,
     192,  149,   10,   10, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_QAxScript[] = {
    "QAxScript\0\0entered()\0finished()\0result\0"
    "finished(QVariant)\0code,source,description,help\0"
    "finished(int,QString,QString,QString)\0"
    "state\0stateChanged(int)\0"
    "code,description,sourcePosition,sourceText\0"
    "error(int,QString,int,QString)\0"
};

const QMetaObject QAxScript::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAxScript,
      qt_meta_data_QAxScript, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAxScript::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAxScript::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAxScript::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAxScript))
        return static_cast<void*>(const_cast< QAxScript*>(this));
    return QObject::qt_metacast(_clname);
}

int QAxScript::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: entered(); break;
        case 1: finished(); break;
        case 2: finished((*reinterpret_cast< const QVariant(*)>(_a[1]))); break;
        case 3: finished((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4]))); break;
        case 4: stateChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: error((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4]))); break;
        default: ;
        }
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void QAxScript::entered()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QAxScript::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void QAxScript::finished(const QVariant & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void QAxScript::finished(int _t1, const QString & _t2, const QString & _t3, const QString & _t4)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)), const_cast<void*>(reinterpret_cast<const void*>(&_t4)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void QAxScript::stateChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void QAxScript::error(int _t1, const QString & _t2, int _t3, const QString & _t4)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)), const_cast<void*>(reinterpret_cast<const void*>(&_t4)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}
static const uint qt_meta_data_QAxScriptManager[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      68,   18,   17,   17, 0x05,

 // slots: signature, parameters, type, tag, flags
     112,  110,   17,   17, 0x08,
     181,  138,   17,   17, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QAxScriptManager[] = {
    "QAxScriptManager\0\0"
    "script,code,description,sourcePosition,sourceText\0"
    "error(QAxScript*,int,QString,int,QString)\0"
    "o\0objectDestroyed(QObject*)\0"
    "code,description,sourcePosition,sourceText\0"
    "scriptError(int,QString,int,QString)\0"
};

const QMetaObject QAxScriptManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QAxScriptManager,
      qt_meta_data_QAxScriptManager, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QAxScriptManager::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QAxScriptManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QAxScriptManager::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QAxScriptManager))
        return static_cast<void*>(const_cast< QAxScriptManager*>(this));
    return QObject::qt_metacast(_clname);
}

int QAxScriptManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: error((*reinterpret_cast< QAxScript*(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5]))); break;
        case 1: objectDestroyed((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 2: scriptError((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4]))); break;
        default: ;
        }
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void QAxScriptManager::error(QAxScript * _t1, int _t2, const QString & _t3, int _t4, const QString & _t5)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)), const_cast<void*>(reinterpret_cast<const void*>(&_t4)), const_cast<void*>(reinterpret_cast<const void*>(&_t5)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
