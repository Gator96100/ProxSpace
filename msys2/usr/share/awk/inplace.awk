# inplace --- load and invoke the inplace extension.
# 
# Copyright (C) 2013, 2017 the Free Software Foundation, Inc.
# 
# This file is part of GAWK, the GNU implementation of the
# AWK Programming Language.
# 
# GAWK is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# GAWK is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
#
# Andrew J. Schorr, aschorr@telemetry-investments.com
# January 2013

@load "inplace"

# Please set INPLACE_SUFFIX to make a backup copy.  For example, you may
# want to set INPLACE_SUFFIX to .bak on the command line or in a BEGIN rule.

# By default, each filename on the command line will be edited inplace.
# But you can selectively disable this by adding an inplace=0 argument
# prior to files that you do not want to process this way.  You can then
# reenable it later on the commandline by putting inplace=1 before files
# that you wish to be subject to inplace editing.

# N.B. We call inplace_end() in the BEGINFILE and END rules so that any
# actions in an ENDFILE rule will be redirected as expected.

BEGIN {
    inplace = 1         # enabled by default
}

BEGINFILE {
    if (_inplace_filename != "")
        inplace_end(_inplace_filename, INPLACE_SUFFIX)
    if (inplace)
        inplace_begin(_inplace_filename = FILENAME, INPLACE_SUFFIX)
    else
        _inplace_filename = ""
}

END {
    if (_inplace_filename != "")
        inplace_end(_inplace_filename, INPLACE_SUFFIX)
}
