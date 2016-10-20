/****************************************************************************
** Meta object code from reading C++ file 'qfont.h'
**
** Created: Thu Feb 11 02:22:53 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../text/qfont.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qfont.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QFont[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       1,   14, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // enums: name, flags, count, data
       6, 0x0,   11,   18,

 // enum data: key, value
      20, uint(QFont::PreferDefault),
      34, uint(QFont::PreferBitmap),
      47, uint(QFont::PreferDevice),
      60, uint(QFont::PreferOutline),
      74, uint(QFont::ForceOutline),
      87, uint(QFont::PreferMatch),
      99, uint(QFont::PreferQuality),
     113, uint(QFont::PreferAntialias),
     129, uint(QFont::NoAntialias),
     141, uint(QFont::OpenGLCompatible),
     158, uint(QFont::NoFontMerging),

       0        // eod
};

static const char qt_meta_stringdata_QFont[] = {
    "QFont\0StyleStrategy\0PreferDefault\0"
    "PreferBitmap\0PreferDevice\0PreferOutline\0"
    "ForceOutline\0PreferMatch\0PreferQuality\0"
    "PreferAntialias\0NoAntialias\0"
    "OpenGLCompatible\0NoFontMerging\0"
};

const QMetaObject QFont::staticMetaObject = {
    { 0, qt_meta_stringdata_QFont,
      qt_meta_data_QFont, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QFont::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION
QT_END_MOC_NAMESPACE
