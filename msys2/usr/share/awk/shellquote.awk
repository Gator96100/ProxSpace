# shell_quote --- quote an argument for passing to the shell
#
# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.
#
# Michael Brennan
# brennan@madronabluff.com
# September 2014

function shell_quote(s,             # parameter
    SINGLE, QSINGLE, i, X, n, ret)  # locals
{
    if (s == "")
        return "\"\""

    SINGLE = "\x27"  # single quote
    QSINGLE = "\"\x27\""
    n = split(s, X, SINGLE)

    ret = SINGLE X[1] SINGLE
    for (i = 2; i <= n; i++)
        ret = ret QSINGLE SINGLE X[i] SINGLE

    return ret
}
