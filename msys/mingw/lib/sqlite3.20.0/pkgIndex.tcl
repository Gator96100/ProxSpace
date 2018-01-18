#
# Tcl package index file
#
# Note sqlite*3* init specifically
#
package ifneeded sqlite3 3.20.0 \
    [list load [file join $dir sqlite3200.dll] Sqlite3]
