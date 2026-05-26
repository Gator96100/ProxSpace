# ctime.awk
#
# awk version of C ctime(3) function
#
# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.

function ctime(ts,    format)
{
    format = "%a %b %e %H:%M:%S %Z %Y"

    if (ts == 0)
        ts = systime()       # use current time as default
    return strftime(format, ts)
}
