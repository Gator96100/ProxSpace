# itclConfig.sh --
# 
# This shell script (for sh) is generated automatically by Itcl's
# configure script.  It will create shell variables for most of
# the configuration options discovered by the configure script.
# This script is intended to be included by the configure scripts
# for Itcl extensions so that they don't have to figure this all
# out for themselves.  This file does not duplicate information
# already provided by tclConfig.sh, so you may need to use that
# file in addition to this one.
#
# The information in this file is specific to a single platform.

# Itcl's version number.
itcl_VERSION='4.1.0'
ITCL_VERSION='4.1.0'

# The name of the Itcl library (may be either a .a file or a shared library):
itcl_LIB_FILE=itcl410.dll
ITCL_LIB_FILE=itcl410.dll

# String to pass to linker to pick up the Itcl library from its
# build directory.
itcl_BUILD_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litcl410'
ITCL_BUILD_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litcl410'

# String to pass to linker to pick up the Itcl library from its
# installed directory.
itcl_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litcl410'
ITCL_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litcl410'

# The name of the Itcl stub library (a .a file):
itcl_STUB_LIB_FILE=libitclstub410.a
ITCL_STUB_LIB_FILE=libitclstub410.a

# String to pass to linker to pick up the Itcl stub library from its
# build directory.
itcl_BUILD_STUB_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litclstub410'
ITCL_BUILD_STUB_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litclstub410'

# String to pass to linker to pick up the Itcl stub library from its
# installed directory.
itcl_STUB_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litclstub410'
ITCL_STUB_LIB_SPEC='-L/mingw64/lib/itcl4.1.0 -litclstub410'

# String to pass to linker to pick up the Itcl stub library from its
# build directory.
itcl_BUILD_STUB_LIB_PATH='/mingw64/lib/itcl4.1.0/libitclstub410.a'
ITCL_BUILD_STUB_LIB_PATH='/mingw64/lib/itcl4.1.0/libitclstub410.a'

# String to pass to linker to pick up the Itcl stub library from its
# installed directory.
itcl_STUB_LIB_PATH='/mingw64/lib/itcl4.1.0/libitclstub410.a'
ITCL_STUB_LIB_PATH='/mingw64/lib/itcl4.1.0/libitclstub410.a'

# Location of the top-level source directories from which [incr Tcl]
# was built.  This is the directory that contains generic, unix, etc.
# If [incr Tcl] was compiled in a different place than the directory
# containing the source files, this points to the location of the sources,
# not the location where [incr Tcl] was compiled.
itcl_SRC_DIR='/scripts/mingw-w64-tcl/src/tcl8.6.7/pkgs/itcl4.1.0'
ITCL_SRC_DIR='/scripts/mingw-w64-tcl/src/tcl8.6.7/pkgs/itcl4.1.0'

# String to pass to the compiler so that an extension can
# find installed Itcl headers.
itcl_INCLUDE_SPEC='/scripts/mingw-w64-tcl/src/tcl8.6.7/pkgs/itcl4.1.0/generic'
ITCL_INCLUDE_SPEC='/scripts/mingw-w64-tcl/src/tcl8.6.7/pkgs/itcl4.1.0/generic'
