/****************************************************************************
** Meta object code from reading C++ file 'qlcdnumber.h'
**
** Created: Thu Feb 11 02:23:25 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../widgets/qlcdnumber.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qlcdnumber.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QLCDNumber[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       7,   59, // properties
       2,   80, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x05,

 // slots: signature, parameters, type, tag, flags
      27,   23,   11,   11, 0x0a,
      48,   44,   11,   11, 0x0a,
      61,   44,   11,   11, 0x0a,
      77,   11,   11,   11, 0x0a,
      90,   11,   11,   11, 0x0a,
     103,   11,   11,   11, 0x0a,
     116,   11,   11,   11, 0x0a,
     129,   11,   11,   11, 0x0a,

 // properties: name, type, flags
     161,  156, 0x01095103,
     183,  179, 0x02095103,
     193,  179, 0x02095103,
     209,  204, 0x0009510b,
     227,  214, 0x0009510b,
     247,  240, 0x06095003,
     253,  179, 0x02095003,

 // enums: name, flags, count, data
     204, 0x0,    4,   88,
     214, 0x0,    3,   96,

 // enum data: key, value
     262, uint(QLCDNumber::Hex),
     266, uint(QLCDNumber::Dec),
     270, uint(QLCDNumber::Oct),
     274, uint(QLCDNumber::Bin),
     278, uint(QLCDNumber::Outline),
     286, uint(QLCDNumber::Filled),
     293, uint(QLCDNumber::Flat),

       0        // eod
};

static const char qt_meta_stringdata_QLCDNumber[] = {
    "QLCDNumber\0\0overflow()\0str\0display(QString)\0"
    "num\0display(int)\0display(double)\0"
    "setHexMode()\0setDecMode()\0setOctMode()\0"
    "setBinMode()\0setSmallDecimalPoint(bool)\0"
    "bool\0smallDecimalPoint\0int\0numDigits\0"
    "digitCount\0Mode\0mode\0SegmentStyle\0"
    "segmentStyle\0double\0value\0intValue\0"
    "Hex\0Dec\0Oct\0Bin\0Outline\0Filled\0Flat\0"
};

const QMetaObject QLCDNumber::staticMetaObject = {
    { &QFrame::staticMetaObject, qt_meta_stringdata_QLCDNumber,
      qt_meta_data_QLCDNumber, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QLCDNumber::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QLCDNumber::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QLCDNumber::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QLCDNumber))
        return static_cast<void*>(const_cast< QLCDNumber*>(this));
    return QFrame::qt_metacast(_clname);
}

int QLCDNumber::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QFrame::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: overflow(); break;
        case 1: display((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: display((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: display((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 4: setHexMode(); break;
        case 5: setDecMode(); break;
        case 6: setOctMode(); break;
        case 7: setBinMode(); break;
        case 8: setSmallDecimalPoint((*reinterpret_cast< bool(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = smallDecimalPoint(); break;
        case 1: *reinterpret_cast< int*>(_v) = numDigits(); break;
        case 2: *reinterpret_cast< int*>(_v) = digitCount(); break;
        case 3: *reinterpret_cast< Mode*>(_v) = mode(); break;
        case 4: *reinterpret_cast< SegmentStyle*>(_v) = segmentStyle(); break;
        case 5: *reinterpret_cast< double*>(_v) = value(); break;
        case 6: *reinterpret_cast< int*>(_v) = intValue(); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setSmallDecimalPoint(*reinterpret_cast< bool*>(_v)); break;
        case 1: setNumDigits(*reinterpret_cast< int*>(_v)); break;
        case 2: setDigitCount(*reinterpret_cast< int*>(_v)); break;
        case 3: setMode(*reinterpret_cast< Mode*>(_v)); break;
        case 4: setSegmentStyle(*reinterpret_cast< SegmentStyle*>(_v)); break;
        case 5: display(*reinterpret_cast< double*>(_v)); break;
        case 6: display(*reinterpret_cast< int*>(_v)); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QLCDNumber::overflow()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
