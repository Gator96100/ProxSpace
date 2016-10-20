/****************************************************************************
** Meta object code from reading C++ file 'qcoreevent.h'
**
** Created: Thu Feb 11 02:05:16 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../kernel/qcoreevent.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qcoreevent.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QEvent[] = {

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
       7, 0x0,  169,   18,

 // enum data: key, value
      12, uint(QEvent::None),
      17, uint(QEvent::Timer),
      23, uint(QEvent::MouseButtonPress),
      40, uint(QEvent::MouseButtonRelease),
      59, uint(QEvent::MouseButtonDblClick),
      79, uint(QEvent::MouseMove),
      89, uint(QEvent::KeyPress),
      98, uint(QEvent::KeyRelease),
     109, uint(QEvent::FocusIn),
     117, uint(QEvent::FocusOut),
     126, uint(QEvent::Enter),
     132, uint(QEvent::Leave),
     138, uint(QEvent::Paint),
     144, uint(QEvent::Move),
     149, uint(QEvent::Resize),
     156, uint(QEvent::Create),
     163, uint(QEvent::Destroy),
     171, uint(QEvent::Show),
     176, uint(QEvent::Hide),
     181, uint(QEvent::Close),
     187, uint(QEvent::Quit),
     192, uint(QEvent::ParentChange),
     205, uint(QEvent::ParentAboutToChange),
     225, uint(QEvent::Reparent),
     234, uint(QEvent::ThreadChange),
     247, uint(QEvent::WindowActivate),
     262, uint(QEvent::WindowDeactivate),
     279, uint(QEvent::ShowToParent),
     292, uint(QEvent::HideToParent),
     305, uint(QEvent::Wheel),
     311, uint(QEvent::WindowTitleChange),
     329, uint(QEvent::WindowIconChange),
     346, uint(QEvent::ApplicationWindowIconChange),
     374, uint(QEvent::ApplicationFontChange),
     396, uint(QEvent::ApplicationLayoutDirectionChange),
     429, uint(QEvent::ApplicationPaletteChange),
     454, uint(QEvent::PaletteChange),
     468, uint(QEvent::Clipboard),
     478, uint(QEvent::Speech),
     485, uint(QEvent::MetaCall),
     494, uint(QEvent::SockAct),
     502, uint(QEvent::WinEventAct),
     514, uint(QEvent::DeferredDelete),
     529, uint(QEvent::DragEnter),
     539, uint(QEvent::DragMove),
     548, uint(QEvent::DragLeave),
     558, uint(QEvent::Drop),
     563, uint(QEvent::DragResponse),
     576, uint(QEvent::ChildAdded),
     587, uint(QEvent::ChildPolished),
     601, uint(QEvent::ChildInsertedRequest),
     622, uint(QEvent::ChildInserted),
     636, uint(QEvent::LayoutHint),
     647, uint(QEvent::ChildRemoved),
     660, uint(QEvent::ShowWindowRequest),
     678, uint(QEvent::PolishRequest),
     692, uint(QEvent::Polish),
     699, uint(QEvent::LayoutRequest),
     713, uint(QEvent::UpdateRequest),
     727, uint(QEvent::UpdateLater),
     739, uint(QEvent::EmbeddingControl),
     756, uint(QEvent::ActivateControl),
     772, uint(QEvent::DeactivateControl),
     790, uint(QEvent::ContextMenu),
     802, uint(QEvent::InputMethod),
     814, uint(QEvent::AccessibilityPrepare),
     835, uint(QEvent::TabletMove),
     846, uint(QEvent::LocaleChange),
     859, uint(QEvent::LanguageChange),
     874, uint(QEvent::LayoutDirectionChange),
     896, uint(QEvent::Style),
     902, uint(QEvent::TabletPress),
     914, uint(QEvent::TabletRelease),
     928, uint(QEvent::OkRequest),
     938, uint(QEvent::HelpRequest),
     950, uint(QEvent::IconDrag),
     959, uint(QEvent::FontChange),
     970, uint(QEvent::EnabledChange),
     984, uint(QEvent::ActivationChange),
    1001, uint(QEvent::StyleChange),
    1013, uint(QEvent::IconTextChange),
    1028, uint(QEvent::ModifiedChange),
    1043, uint(QEvent::MouseTrackingChange),
    1063, uint(QEvent::WindowBlocked),
    1077, uint(QEvent::WindowUnblocked),
    1093, uint(QEvent::WindowStateChange),
    1111, uint(QEvent::ToolTip),
    1119, uint(QEvent::WhatsThis),
    1129, uint(QEvent::StatusTip),
    1139, uint(QEvent::ActionChanged),
    1153, uint(QEvent::ActionAdded),
    1165, uint(QEvent::ActionRemoved),
    1179, uint(QEvent::FileOpen),
    1188, uint(QEvent::Shortcut),
    1197, uint(QEvent::ShortcutOverride),
    1214, uint(QEvent::Accel),
    1220, uint(QEvent::AccelAvailable),
    1235, uint(QEvent::AccelOverride),
    1249, uint(QEvent::WhatsThisClicked),
    1266, uint(QEvent::CaptionChange),
    1280, uint(QEvent::IconChange),
    1291, uint(QEvent::ToolBarChange),
    1305, uint(QEvent::ApplicationActivate),
    1325, uint(QEvent::ApplicationActivated),
    1346, uint(QEvent::ApplicationDeactivate),
    1368, uint(QEvent::ApplicationDeactivated),
    1391, uint(QEvent::QueryWhatsThis),
    1406, uint(QEvent::EnterWhatsThisMode),
    1425, uint(QEvent::LeaveWhatsThisMode),
    1444, uint(QEvent::ZOrderChange),
    1457, uint(QEvent::HoverEnter),
    1468, uint(QEvent::HoverLeave),
    1479, uint(QEvent::HoverMove),
    1489, uint(QEvent::AccessibilityHelp),
    1507, uint(QEvent::AccessibilityDescription),
    1532, uint(QEvent::AcceptDropsChange),
    1550, uint(QEvent::MenubarUpdated),
    1565, uint(QEvent::ZeroTimerEvent),
    1580, uint(QEvent::GraphicsSceneMouseMove),
    1603, uint(QEvent::GraphicsSceneMousePress),
    1627, uint(QEvent::GraphicsSceneMouseRelease),
    1653, uint(QEvent::GraphicsSceneMouseDoubleClick),
    1683, uint(QEvent::GraphicsSceneContextMenu),
    1708, uint(QEvent::GraphicsSceneHoverEnter),
    1732, uint(QEvent::GraphicsSceneHoverMove),
    1755, uint(QEvent::GraphicsSceneHoverLeave),
    1779, uint(QEvent::GraphicsSceneHelp),
    1797, uint(QEvent::GraphicsSceneDragEnter),
    1820, uint(QEvent::GraphicsSceneDragMove),
    1842, uint(QEvent::GraphicsSceneDragLeave),
    1865, uint(QEvent::GraphicsSceneDrop),
    1883, uint(QEvent::GraphicsSceneWheel),
    1902, uint(QEvent::KeyboardLayoutChange),
    1923, uint(QEvent::DynamicPropertyChange),
    1945, uint(QEvent::TabletEnterProximity),
    1966, uint(QEvent::TabletLeaveProximity),
    1987, uint(QEvent::NonClientAreaMouseMove),
    2010, uint(QEvent::NonClientAreaMouseButtonPress),
    2040, uint(QEvent::NonClientAreaMouseButtonRelease),
    2072, uint(QEvent::NonClientAreaMouseButtonDblClick),
    2105, uint(QEvent::MacSizeChange),
    2119, uint(QEvent::ContentsRectChange),
    2138, uint(QEvent::MacGLWindowChange),
    2156, uint(QEvent::FutureCallOut),
    2170, uint(QEvent::GraphicsSceneResize),
    2190, uint(QEvent::GraphicsSceneMove),
    2208, uint(QEvent::CursorChange),
    2221, uint(QEvent::ToolTipChange),
    2235, uint(QEvent::NetworkReplyUpdated),
    2255, uint(QEvent::GrabMouse),
    2265, uint(QEvent::UngrabMouse),
    2277, uint(QEvent::GrabKeyboard),
    2290, uint(QEvent::UngrabKeyboard),
    2305, uint(QEvent::CocoaRequestModal),
    2323, uint(QEvent::MacGLClearDrawable),
    2342, uint(QEvent::StateMachineSignal),
    2361, uint(QEvent::StateMachineWrapped),
    2381, uint(QEvent::TouchBegin),
    2392, uint(QEvent::TouchUpdate),
    2404, uint(QEvent::TouchEnd),
    2413, uint(QEvent::NativeGesture),
    2427, uint(QEvent::RequestSoftwareInputPanel),
    2453, uint(QEvent::CloseSoftwareInputPanel),
    2477, uint(QEvent::UpdateSoftKeys),
    2492, uint(QEvent::WinIdChange),
    2504, uint(QEvent::Gesture),
    2512, uint(QEvent::GestureOverride),
    2528, uint(QEvent::User),
    2533, uint(QEvent::MaxUser),

       0        // eod
};

static const char qt_meta_stringdata_QEvent[] = {
    "QEvent\0Type\0None\0Timer\0MouseButtonPress\0"
    "MouseButtonRelease\0MouseButtonDblClick\0"
    "MouseMove\0KeyPress\0KeyRelease\0FocusIn\0"
    "FocusOut\0Enter\0Leave\0Paint\0Move\0Resize\0"
    "Create\0Destroy\0Show\0Hide\0Close\0Quit\0"
    "ParentChange\0ParentAboutToChange\0"
    "Reparent\0ThreadChange\0WindowActivate\0"
    "WindowDeactivate\0ShowToParent\0"
    "HideToParent\0Wheel\0WindowTitleChange\0"
    "WindowIconChange\0ApplicationWindowIconChange\0"
    "ApplicationFontChange\0"
    "ApplicationLayoutDirectionChange\0"
    "ApplicationPaletteChange\0PaletteChange\0"
    "Clipboard\0Speech\0MetaCall\0SockAct\0"
    "WinEventAct\0DeferredDelete\0DragEnter\0"
    "DragMove\0DragLeave\0Drop\0DragResponse\0"
    "ChildAdded\0ChildPolished\0ChildInsertedRequest\0"
    "ChildInserted\0LayoutHint\0ChildRemoved\0"
    "ShowWindowRequest\0PolishRequest\0Polish\0"
    "LayoutRequest\0UpdateRequest\0UpdateLater\0"
    "EmbeddingControl\0ActivateControl\0"
    "DeactivateControl\0ContextMenu\0InputMethod\0"
    "AccessibilityPrepare\0TabletMove\0"
    "LocaleChange\0LanguageChange\0"
    "LayoutDirectionChange\0Style\0TabletPress\0"
    "TabletRelease\0OkRequest\0HelpRequest\0"
    "IconDrag\0FontChange\0EnabledChange\0"
    "ActivationChange\0StyleChange\0"
    "IconTextChange\0ModifiedChange\0"
    "MouseTrackingChange\0WindowBlocked\0"
    "WindowUnblocked\0WindowStateChange\0"
    "ToolTip\0WhatsThis\0StatusTip\0ActionChanged\0"
    "ActionAdded\0ActionRemoved\0FileOpen\0"
    "Shortcut\0ShortcutOverride\0Accel\0"
    "AccelAvailable\0AccelOverride\0"
    "WhatsThisClicked\0CaptionChange\0"
    "IconChange\0ToolBarChange\0ApplicationActivate\0"
    "ApplicationActivated\0ApplicationDeactivate\0"
    "ApplicationDeactivated\0QueryWhatsThis\0"
    "EnterWhatsThisMode\0LeaveWhatsThisMode\0"
    "ZOrderChange\0HoverEnter\0HoverLeave\0"
    "HoverMove\0AccessibilityHelp\0"
    "AccessibilityDescription\0AcceptDropsChange\0"
    "MenubarUpdated\0ZeroTimerEvent\0"
    "GraphicsSceneMouseMove\0GraphicsSceneMousePress\0"
    "GraphicsSceneMouseRelease\0"
    "GraphicsSceneMouseDoubleClick\0"
    "GraphicsSceneContextMenu\0"
    "GraphicsSceneHoverEnter\0GraphicsSceneHoverMove\0"
    "GraphicsSceneHoverLeave\0GraphicsSceneHelp\0"
    "GraphicsSceneDragEnter\0GraphicsSceneDragMove\0"
    "GraphicsSceneDragLeave\0GraphicsSceneDrop\0"
    "GraphicsSceneWheel\0KeyboardLayoutChange\0"
    "DynamicPropertyChange\0TabletEnterProximity\0"
    "TabletLeaveProximity\0NonClientAreaMouseMove\0"
    "NonClientAreaMouseButtonPress\0"
    "NonClientAreaMouseButtonRelease\0"
    "NonClientAreaMouseButtonDblClick\0"
    "MacSizeChange\0ContentsRectChange\0"
    "MacGLWindowChange\0FutureCallOut\0"
    "GraphicsSceneResize\0GraphicsSceneMove\0"
    "CursorChange\0ToolTipChange\0"
    "NetworkReplyUpdated\0GrabMouse\0UngrabMouse\0"
    "GrabKeyboard\0UngrabKeyboard\0"
    "CocoaRequestModal\0MacGLClearDrawable\0"
    "StateMachineSignal\0StateMachineWrapped\0"
    "TouchBegin\0TouchUpdate\0TouchEnd\0"
    "NativeGesture\0RequestSoftwareInputPanel\0"
    "CloseSoftwareInputPanel\0UpdateSoftKeys\0"
    "WinIdChange\0Gesture\0GestureOverride\0"
    "User\0MaxUser\0"
};

const QMetaObject QEvent::staticMetaObject = {
    { 0, qt_meta_stringdata_QEvent,
      qt_meta_data_QEvent, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QEvent::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION
QT_END_MOC_NAMESPACE
