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