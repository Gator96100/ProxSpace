/****************************************************************************
** Meta object code from reading C++ file 'qtreeview.h'
**
** Created: Thu Feb 11 02:20:18 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../itemviews/qtreeview.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qtreeview.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QTreeView[] = {

 // content:
       4,       // revision
       0,       // classname
       0,    0, // classinfo
      19,   14, // methods
      11,  109, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   11,   10,   10, 0x05,
      39,   11,   10,   10, 0x05,

 // slots: signature, parameters, type, tag, flags
      69,   62,   10,   10, 0x0a,
      85,   62,   10,   10, 0x0a,
     101,   11,   10,   10, 0x0a,
     121,   11,   10,   10, 0x0a,
     143,   62,   10,   10, 0x0a,
     171,   62,   10,   10, 0x0a,
     189,   10,   10,   10, 0x0a,
     201,   10,   10,   10, 0x0a,
     221,  215,   10,   10, 0x0a,
     263,  240,   10,   10, 0x09,
     308,  290,   10,   10, 0x09,
     336,   10,   10,   10, 0x09,
     350,   10,   10,   10, 0x09,
     379,  361,   10,   10, 0x09,
     412,   10,   10,   10, 0x08,
     438,   10,   10,   10, 0x08,
     476,  463,   10,   10, 0x08,

 // properties: name, type, flags
     523,  519, 0x02095103,
     539,  519, 0x02095103,
     556,  551, 0x01095103,
     572,  551, 0x01095103,
     590,  551, 0x01095103,
     606,  551, 0x01095103,
     621,  551, 0x01095103,
     630,  551, 0x01095103,
     650,  551, 0x01095103,
     659,  551, 0x01095103,
     672,  551, 0x01095103,

       0        // eod
};

static const char qt_meta_stringdata_QTreeView[] = {
    "QTreeView\0\0index\0expanded(QModelIndex)\0"
    "collapsed(QModelIndex)\0column\0"
    "hideColumn(int)\0showColumn(int)\0"
    "expand(QModelIndex)\0collapse(QModelIndex)\0"
    "resizeColumnToContents(int)\0"
    "sortByColumn(int)\0expandAll()\0"
    "collapseAll()\0depth\0expandToDepth(int)\0"
    "column,oldSize,newSize\0"
    "columnResized(int,int,int)\0oldCount,newCount\0"
    "columnCountChanged(int,int)\0columnMoved()\0"
    "reexpand()\0parent,first,last\0"
    "rowsRemoved(QModelIndex,int,int)\0"
    "_q_endAnimatedOperation()\0"
    "_q_modelAboutToBeReset()\0column,order\0"
    "_q_sortIndicatorChanged(int,Qt::SortOrder)\0"
    "int\0autoExpandDelay\0indentation\0bool\0"
    "rootIsDecorated\0uniformRowHeights\0"
    "itemsExpandable\0sortingEnabled\0animated\0"
    "allColumnsShowFocus\0wordWrap\0headerHidden\0"
    "expandsOnDoubleClick\0"
};

const QMetaObject QTreeView::staticMetaObject = {
    { &QAbstractItemView::staticMetaObject, qt_meta_stringdata_QTreeView,
      qt_meta_data_QTreeView, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QTreeView::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QTreeView::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QTreeView::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QTreeView))
        return static_cast<void*>(const_cast< QTreeView*>(this));
    return QAbstractItemView::qt_metacast(_clname);
}

int QTreeView::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractItemView::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: expanded((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 1: collapsed((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 2: hideColumn((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: showColumn((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: expand((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 5: collapse((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 6: resizeColumnToContents((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: sortByColumn((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: expandAll(); break;
        case 9: collapseAll(); break;
        case 10: expandToDepth((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: columnResized((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 12: columnCountChanged((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 13: columnMoved(); break;
        case 14: reexpand(); break;
        case 15: rowsRemoved((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 16: d_func()->_q_endAnimatedOperation(); break;
        case 17: d_func()->_q_modelAboutToBeReset(); break;
        case 18: d_func()->_q_sortIndicatorChanged((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< Qt::SortOrder(*)>(_a[2]))); break;
        default: ;
        }
        _id -= 19;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = autoExpandDelay(); break;
        case 1: *reinterpret_cast< int*>(_v) = indentation(); break;
        case 2: *reinterpret_cast< bool*>(_v) = rootIsDecorated(); break;
        case 3: *reinterpret_cast< bool*>(_v) = uniformRowHeights(); break;
        case 4: *reinterpret_cast< bool*>(_v) = itemsExpandable(); break;
        case 5: *reinterpret_cast< bool*>(_v) = isSortingEnabled(); break;
        case 6: *reinterpret_cast< bool*>(_v) = isAnimated(); break;
        case 7: *reinterpret_cast< bool*>(_v) = allColumnsShowFocus(); break;
        case 8: *reinterpret_cast< bool*>(_v) = wordWrap(); break;
        case 9: *reinterpret_cast< bool*>(_v) = isHeaderHidden(); break;
        case 10: *reinterpret_cast< bool*>(_v) = expandsOnDoubleClick(); break;
        }
        _id -= 11;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setAutoExpandDelay(*reinterpret_cast< int*>(_v)); break;
        case 1: setIndentation(*reinterpret_cast< int*>(_v)); break;
        case 2: setRootIsDecorated(*reinterpret_cast< bool*>(_v)); break;
        case 3: setUniformRowHeights(*reinterpret_cast< bool*>(_v)); break;
        case 4: setItemsExpandable(*reinterpret_cast< bool*>(_v)); break;
        case 5: setSortingEnabled(*reinterpret_cast< bool*>(_v)); break;
        case 6: setAnimated(*reinterpret_cast< bool*>(_v)); break;
        case 7: setAllColumnsShowFocus(*reinterpret_cast< bool*>(_v)); break;
        case 8: setWordWrap(*reinterpret_cast< bool*>(_v)); break;
        case 9: setHeaderHidden(*reinterpret_cast< bool*>(_v)); break;
        case 10: setExpandsOnDoubleClick(*reinterpret_cast< bool*>(_v)); break;
        }
        _id -= 11;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 11;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 11;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QTreeView::expanded(const QModelIndex & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QTreeView::collapsed(const QModelIndex & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
