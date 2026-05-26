# readfile.awk --- read an entire file at once
#
# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.
#
# Original idea by Denis Shirokov, cosmogen@gmail.com, April 2013

function readfile(file,     tmp, save_rs)
{
    save_rs = RS
    RS = "^$"
    getline tmp < file
    close(file)
    RS = save_rs

    return tmp
}
