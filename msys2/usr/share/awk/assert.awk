# assert --- assert that a condition is true. Otherwise, exit.
#
# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.
#
# Arnold Robbins, arnold@skeeve.com, Public Domain
# May, 1993

function assert(condition, string)
{
    if (! condition) {
        printf("%s:%d: assertion failed: %s\n",
            FILENAME, FNR, string) > "/dev/stderr"
        _assert_exit = 1
        exit 1
    }
}

END {
    if (_assert_exit)
        exit 1
}
