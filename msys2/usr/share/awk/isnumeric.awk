# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.

# isnumeric --- check whether a value is numeric

function isnumeric(x,  f)
{
    switch (typeof(x)) {
    case "strnum":
    case "number":
        return 1
    case "string":
        return (split(x, f, " ") == 1) && (typeof(f[1]) == "strnum")
    default:
        return 0
    }
}
