/****************************************************************************
** Meta object code from reading C++ file 'mediacontroller.h'
**
** Created: Thu Feb 11 02:59:54 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../3rdparty/phonon/phonon/mediacontroller.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mediacontroller.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Phonon__MediaController[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       1,   84, // enums/sets
       0,    0, // constructors
       0,       // flags
       8,       // signalCount

 // signals: signature, parameters, type, tag, flags
      25,   24,   24,   24, 0x05,
      53,   24,   24,   24, 0x05,
     101,   85,   24,   24, 0x05,
     141,  129,   24,   24, 0x05,
     177,  159,   24,   24, 0x05,
     221,  207,   24,   24, 0x05,
     257,  241,   24,   24, 0x05,
     297,  285,   24,   24, 0x05,

 // slots: signature, parameters, type, tag, flags
     315,  129,   24,   24, 0x0a,
     336,  207,   24,   24, 0x0a,
     359,  285,   24,   24, 0x0a,
     380,   24,   24,   24, 0x0a,
     404,   24,   24,   24, 0x0a,
     416,   24,   24,   24, 0x0a,

 // enums: name, flags, count, data
     432, 0x1,    3,   88,

 // enum data: key, value
     441, uint(Phonon::MediaController::Angles),
     448, uint(Phonon::MediaController::Chapters),
     457, uint(Phonon::MediaController::Titles),

       0        // eod
};

static const char qt_meta_stringdata_Phonon__MediaController[] = {
    "Phonon::MediaController\0\0"
    "availableSubtitlesChanged()\0"
    "availableAudioChannelsChanged()\0"
    "availableAngles\0availableAnglesChanged(int)\0"
    "angleNumber\0angleChanged(int)\0"
    "availableChapters\0availableChaptersChanged(int)\0"
    "chapterNumber\0chapterChanged(int)\0"
    "availableTitles\0availableTitlesChanged(int)\0"
    "titleNumber\0titleChanged(int)\0"
    "setCurrentAngle(int)\0setCurrentChapter(int)\0"
    "setCurrentTitle(int)\0setAutoplayTitles(bool)\0"
    "nextTitle()\0previousTitle()\0Features\0"
    "Angles\0Chapters\0Titles\0"
};

const QMetaObject Phonon::MediaController::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Phonon__MediaController,
      qt_meta_data_Phonon__MediaController, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Phonon::MediaController::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Phonon::MediaController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Phonon::MediaController::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Phonon__MediaController))
        return static_cast<void*>(const_cast< MediaController*>(this));
    return QObject::qt_metacast(_clname);
}

int Phonon::MediaController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: availableSubtitlesChanged(); break;
        case 1: availableAudioChannelsChanged(); break;
        case 2: availableAnglesChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: angleChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: availableChaptersChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: chapterChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: availableTitlesChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: titleChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: setCurrentAngle((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: setCurrentChapter((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 10: setCurrentTitle((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: setAutoplayTitles((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: nextTitle(); break;
        case 13: previousTitle(); break;
        default: ;
        }
        _id -= 14;
    }
    return _id;
}

// SIGNAL 0
void Phonon::MediaController::availableSubtitlesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void Phonon::MediaController::availableAudioChannelsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void Phonon::MediaController::availableAnglesChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Phonon::MediaController::angleChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void Phonon::MediaController::availableChaptersChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void Phonon::MediaController::chapterChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void Phonon::MediaController::availableTitlesChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void Phonon::MediaController::titleChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}
QT_END_MOC_NAMESPACE
