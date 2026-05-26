# adequate_math_precision --- return true if we have enough bits
#
# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.
#
# Andrew Schorr, aschorr@telemetry-investments.com, Public Domain
# May 2017

function adequate_math_precision(n)
{
    return (1 != (1+(1/(2^(n-1)))))
}
