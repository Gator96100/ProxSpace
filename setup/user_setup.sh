#!/bin/bash
MKPASSWD_CURRENT="$( mkpasswd -c )"
MKGROUP_CURRENT="$( mkgroup -c )"
USER_SID="$( echo $MKPASSWD_CURRENT | gawk -F":" '{ print $5 }' )"
GID="$( echo $MKPASSWD_CURRENT | gawk -F":" '{ print $4 }' )"
GROUP_SID="$( echo $MKGROUP_CURRENT | gawk -F":" '{ print $2 }' )"

# Check if user is in /etc/mkpasswd
USER_MISSING=$( grep -Fq "$USER_SID" /etc/passwd )$?
# If not, add it
if [ $USER_MISSING != 0 ]; then
  echo proxspace:unused:1001:$GID:$USER_SID:/pm3:/bin/bash >> /etc/passwd
fi

# Check if group is in /etc/group
GROUP_MISSING=$( grep -Fq "$GROUP_SID" /etc/group )$?
# If not, add it
if [ $GROUP_MISSING != 0 ]; then
  echo $MKGROUP_CURRENT >> /etc/group
fi

# ProxSpace compiler overrides — use bundled MinGW64, ignore host env.
# Fixes issue #60: users with a system MinGW install (Qt Creator, TDM-GCC)
# inherit incorrect compiler paths that break the Proxmark3 build.
export MINGW_HOME=/mingw64
export CC=/mingw64/bin/gcc.exe
export CXX=/mingw64/bin/g++.exe
export AR=/mingw64/bin/ar.exe
