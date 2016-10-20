/****************************************************************************
** Meta object code from reading C++ file 'qtextureglyphcache_gl_p.h'
**
** Created: Thu Feb 11 02:45:16 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../gl2paintengineex/qtextureglyphcache_gl_p.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qtextureglyphcache_gl_p.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QGLTextureGlyphCache[] = {

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
      30,   22,   21,   21, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_QGLTextureGlyphCache[] = {
    "QGLTextureGlyphCache\0\0context\0"
    "contextDestroyed(const QGLContext*)\0"
};

const QMetaObject QGLTextureGlyphCache::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QGLTextureGlyphCache,
      qt_meta_data_QGLTextureGlyphCache, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGLTextureGlyphCache::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QGLTextureGlyphCache::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QGLTextureGlyphCache::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QGLTextureGlyphCache))
        return static_cast<void*>(const_cast< QGLTextureGlyphCache*>(this));
    if (!strcmp(_clname, "QTextureGlyphCache"))
        return static_cast< QTextureGlyphCache*>(const_cast< QGLTextureGlyphCache*>(this));
    return QObject::qt_metacast(_clname);
}

int QGLTextureGlyphCache::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: contextDestroyed((*reinterpret_cast< const QGLContext*(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
