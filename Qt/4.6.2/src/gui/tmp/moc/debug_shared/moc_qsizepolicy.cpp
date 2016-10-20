/****************************************************************************
** Meta object code from reading C++ file 'qsizepolicy.h'
**
** Created: Thu Feb 11 02:22:39 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../kernel/qsizepolicy.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qsizepolicy.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QSizePolicy[] = {

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
      12, 0x0,    7,   18,

 // enum data: key, value
      19, uint(QSizePolicy::Fixed),
      25, uint(QSizePolicy::Minimum),
      33, uint(QSizePolicy::Maximum),
      41, uint(QSizePolicy::Preferred),
      51, uint(QSizePolicy::MinimumExpanding),
      68, uint(QSizePolicy::Expanding),
      78, uint(QSizePolicy::Ignored),

       0        // eod
};

static const char qt_meta_stringdata_QSizePolicy[] = {
    "QSizePolicy\0Policy\0Fixed\0Minimum\0"
    "Maximum\0Preferred\0MinimumExpanding\0"
    "Expanding\0Ignored\0"
};

const QMetaObject QSizePolicy::staticMetaObject = {
    { 0, qt_meta_stringdata_QSizePolicy,
      qt_meta_data_QSizePolicy, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QSizePolicy::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION
QT_END_MOC_NAMESPACE
