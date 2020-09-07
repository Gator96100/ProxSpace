# Tcl package index file, version 1.0
#
# Do NOT try this command
# 
#   if {![package vsatisfies [package provide Tcl] 8.6-]} {return}
#
# as a way to accept working with all of Tcl 8.6, Tcl 8.X, X>6, and
# Tcl Y, for Y > 8.
# Itcl is a binary package, added to an interp with [load].
# There is no libitcl.so that will [load] into both Tcl 8 and Tcl 9.
# The indexed libitcl.so was built to [load] into one or the other.
# Thus the pkgIndex.tcl should only accept the version of Tcl for which
# the indexed libitcl4.2.0.dll was built.
#
# More work replacing the literal "8.6" below with the proper value substituted
# by configure is the right way forward.

if {![package vsatisfies [package provide Tcl] 8.6]} {return}

package ifneeded itcl 4.2.0 [list load [file join $dir "libitcl4.2.0.dll"] itcl]
package ifneeded Itcl 4.2.0 [list load [file join $dir "libitcl4.2.0.dll"] itcl]
