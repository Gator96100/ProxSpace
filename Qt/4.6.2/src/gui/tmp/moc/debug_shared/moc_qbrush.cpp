/****************************************************************************
** Meta object code from reading C++ file 'qbrush.h'
**
** Created: Thu Feb 11 02:22:49 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../painting/qbrush.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qbrush.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QGradient[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       3,   14, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // enums: name, flags, count, data
      10, 0x0,    4,   26,
      15, 0x0,    3,   34,
      22, 0x0,    3,   40,

 // enum data: key, value
      37, uint(QGradient::LinearGradient),
      52, uint(QGradient::RadialGradient),
      67, uint(QGradient::ConicalGradient),
      83, uint(QGradient::NoGradient),
      94, uint(QGradient::PadSpread),
     104, uint(QGradient::ReflectSpread),
     118, uint(QGradient::RepeatSpread),
     131, uint(QGradient::LogicalMode),
     143, uint(QGradient::StretchToDeviceMode),
     163, uint(QGradient::ObjectBoundingMode),

       0        // eod
};

static const char qt_meta_stringdata_QGradient[] = {
    "QGradient\0Type\0Spread\0CoordinateMode\0"
    "LinearGradient\0RadialGradient\0"
    "ConicalGradient\0NoGradient\0PadSpread\0"
    "ReflectSpread\0RepeatSpread\0LogicalMode\0"
    "StretchToDeviceMode\0ObjectBoundingMode\0"
};

const QMetaObject QGradient::staticMetaObject = {
    { 0, qt_meta_stringdata_QGradient,
      qt_meta_data_QGradient, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QGradient::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION
QT_END_MOC_NAMESPACE
