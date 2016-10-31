CONFIG+= release shared rtti no_plugin_manifest directwrite qpa
host_build {
    QT_ARCH = i386
    QT_TARGET_ARCH = i386
} else {
    QT_ARCH = i386
}
QT_CONFIG += minimal-config small-config medium-config large-config full-config debug_and_release build_all debug release c++11 c++14 shared system-zlib dynamicgl png freetype harfbuzz build_all accessibility opengl ssl openssl dbus audio-backend directwrite native-gestures qpa iconv concurrent
#versioning 
QT_VERSION = 5.6.1
QT_MAJOR_VERSION = 5
QT_MINOR_VERSION = 6
QT_PATCH_VERSION = 1

QT_EDITION = OpenSource
QT_LICHECK = licheck.exe
QT_RELEASE_DATE = 2016-06-17
QT_GCC_MAJOR_VERSION = 4
QT_GCC_MINOR_VERSION = 9
QT_GCC_PATCH_VERSION = 2

