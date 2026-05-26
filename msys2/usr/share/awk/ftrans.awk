# ftrans.awk --- handle datafile transitions
#
# user supplies beginfile() and endfile() functions
#
# This file and how to use it are described in the manual.
# Therefore, we respectfully advise you to Read The Fine Manual
# for more information.
#
# Arnold Robbins, arnold@skeeve.com, Public Domain
# November 1992

FNR == 1 {
    if (_filename_ != "")
        endfile(_filename_)
    _filename_ = FILENAME
    beginfile(FILENAME)
}

END { endfile(_filename_) }
