/****************************************************************************
** Meta object code from reading C++ file 'qglshaderprogram.h'
**
** Created: Thu Feb 11 02:45:09 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../qglshaderprogram.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qglshaderprogram.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QGLShader[] = {

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

static const char qt_meta_stringdata_QGLShader[] = {
    "QGLShader\0"
};

const QMetaObject QGLShader::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QGLShader,
      qt_meta_data_QGLShader, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGLShader::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGLShader::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGLShader::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGLShader))
        return static_cast<void*>(const_cast< QGLShader*>(this));
    return QObject::qt_metacast(_clname);
}

int QGLShader::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    return _id;
}
static const uint qt_meta_data_QGLShaderProgram[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      18,   17,   17,   17, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_QGLShaderProgram[] = {
    "QGLShaderProgram\0\0shaderDestroyed()\0"
};

const QMetaObject QGLShaderProgram::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QGLShaderProgram,
      qt_meta_data_QGLShaderProgram, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGLShaderProgram::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGLShaderProgram::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGLShaderProgram::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGLShaderProgram))
        return static_cast<void*>(const_cast< QGLShaderProgram*>(this));
    return QObject::qt_metacast(_clname);
}

int QGLShaderProgram::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: shaderDestroyed(); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
