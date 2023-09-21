#!/usr/bin/bash
#
#   python.sh - creating reproducible python packages
#
#   Copyright (c) 2021 Pacman Development Team <pacman-dev@archlinux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

[[ -n "$LIBMAKEPKG_REPRODUCIBLE_PYTHON_SH" ]] && return
LIBMAKEPKG_REPRODUCIBLE_PYTHON_SH=1


LIBRARY=${LIBRARY:-'/usr/share/makepkg'}


# disable hash randomization when creating .pyc files
export PYTHONHASHSEED=0
