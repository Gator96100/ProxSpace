#!perl -w
use strict;

my $dbixs_rev_file = "dbixs_rev.h";

my $is_make_dist;
my $svnversion;

if (is_dbi_svn_dir(".")) {
    $svnversion = `svnversion -n`;
}
elsif (is_dbi_svn_dir("..")) {
    # presumably we're in a subdirectory because the user is doing a 'make dist'
    $svnversion = `svnversion -n ..`;
    $is_make_dist = 1;
}
else {
    # presumably we're being run by an end-user because their file timestamps
    # got messed up
    print "Skipping regeneration of $dbixs_rev_file\n";
    utime(time(), time(), $dbixs_rev_file); # update modification time
    exit 0;
}

my @warn;
die "Neither current directory nor parent directory are an svn working copy\n"
    unless $svnversion and $svnversion =~ m/^\d+/;
push @warn, "Mixed revision working copy ($svnversion:$1)"
    if $svnversion =~ s/:(\d+)//;
push @warn, "Code modified since last checkin"
    if $svnversion =~ s/[MS]+$//;
warn "$dbixs_rev_file warning: $_\n" for @warn;
die "$0 failed\n" if $is_make_dist && @warn;

write_header($dbixs_rev_file, DBIXS_REVISION => $svnversion, \@warn);

sub write_header {
    my ($file, $macro, $version, $comments_ref) = @_;
    open my $fh, ">$file" or die "Can't open $file: $!\n";
    unshift @$comments_ref, scalar localtime(time);
    print $fh "/* $_ */\n" for @$comments_ref;
    print $fh "#define $macro $version\n";
    close $fh or die "Error closing $file: $!\n";
    print "Wrote $macro $version to $file\n";
}

sub is_dbi_svn_dir {
    my ($dir) = @_;
    return (-d "$dir/.svn" && -f "$dir/MANIFEST.SKIP");
}

