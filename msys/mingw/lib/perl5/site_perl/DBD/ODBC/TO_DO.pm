use strict;

=head1 NAME

DBD::ODBC::TO_DO - Things to do in DBD::ODBC

As of $LastChangedDate: 2010-10-08 17:00:31 +0100 (Fri, 08 Oct 2010)$

$Revision: 10667 $

=cut

=head1 Todo

  Get travis testing actually running tests against a driver.

  Better/more tests on multiple statement handles which ensure the
    correct number of rows

  Better/more tests on all queries which ensure the correct number of
    rows and data

  Better tests on SQLExecDirect/do

  Keep checking Oracle's ODBC drivers for Windows to fix the Date
    binding problem

  There is a Columns private ODBC method which is not documented.

  Add support for sending lobs in chunks instead of all in one go. Although
    DBD::ODBC uses SQLParamData and SQLPutData internally they are not exposed
    so anyone binding a lob has to have all of it available before it can
    be bound.

  Why does level 15 tracing of any DBD::ODBC script show alot of these:
    !!DBD::ODBC unsupported attribute passed (PrintError)
    !!DBD::ODBC unsupported attribute passed (Username)
    !!DBD::ODBC unsupported attribute passed (dbi_connect_closure)
    !!DBD::ODBC unsupported attribute passed (LongReadLen)

  Add a perlcritic test - see DBD::Pg

  Anywhere we are storing a value in an SV that we didn't create
    (and thus might have magic) should probably set magic.

  Add a test for ChopBlanks and unicode data

  Add some private SQLGetInfo values for whether SQL_ROWSET_SIZE hack
  works etc. How can you tell a driver supports MARS_CONNECTION.

  Might be able to detect MARS capable with SS_COPT_MARS_ENABLED

  Bump requirement to Test::Simple 0.96 so we can use subtest which
  is really cool and reorganise tests to use it. 0.96, because it seems
  to be the first really stable version of subtest.

  Add more Oracle-specific tests - like calling functions/procedures
  and in/out params.

  Download rpm package from here ->
  http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_11.4/src/
  and see what changes they are making (especially Makefile.PL) to see if we
  might need to include them.

  DRIVER and DSN in ODBC connection attributes should be case insensitive
  and they are not - they are strcmped against DRIVER/DSN - check!

  Some people still have problems with iODBC being picked up before
  unixODBC. Various ideas from irc:

<Caelum> mje: what does undefined symbol: SQLGetFunctions mean?
<Caelum> mje: do I have iodbc conflicting again?
<@Caelum> yeah I think that's it
<mje> perl Makefile.PL -x
* gfx is now known as gfx_away
<Caelum> mje: kinda sucks I have to do that every time, every auto-upgrade borks it
<mje> can't you just uninstall iODBC
<mje> is this OSX?
<@Caelum> it's Debian, I think I have iODBC because amarok needs it
<mje> oh, so use -x
<ribasushi> mje: what if you just compile a quick program in the Makefile itself, and determine whether you need -x or not?
<@ribasushi> I've seen other things to that - e.g. Time::HiRes
<mje> could do, I guess I could revisit this - problem was Jens (I think) sent me a patch to prefer iODBC over unixODBC and told me it was required for something - can't remember right now
<mje> otherwise, I'd just change the default to unixODBC then iODBC
<@Caelum> maybe an env var in addition to -x? then I could just put it in my .zshrc like PERL_DBD_ODBC_PREFER_UNIXODBC
<mje> yeah, could do that too
<ribasushi> mje: the point is you can't really "prefer" one or the other - you need to check for a specific -dev existence, instead of assuming it's there if the package itself is there
<mje> but iODBC and unixODBC dev packages both provide sql.h etc
<mje> you should see the code I already have to try and fathom this out - it is massive
<ribasushi> mje: by check I meant - compile something small and quick to run
<mje> some unixODBC's don't include odbc_config, some do, some do but are too old and don't have switch fred
<mje> to compile correctly I need to find odbc_config or iodbc_config so catch 22
<@ribasushi> but here's the kicker - you compile "something" - if it works - you found things correctly
<@ribasushi> if the compile/execution fails - you "found" wrong
<mje> I don't think it is that simple - I need to know it is iODBC or not and a whole load of other things
<mje> there is a lot of history in the tests for supporting older systems
<@ribasushi> https://metacpan.org/source/ZEFRAM/Time-HiRes-1.9724/Makefile.PL#L334
<ribasushi> mje: ^^ I was referring to stuff like this
<@ribasushi> without changing the heuristics at all, simply looping the whole thing with different params depending on the config outcome
<@ribasushi> it's ugly, but can end up rather effective
<mje> I'll look at it again - added to TO_DO - where does try_compile_and_link come from?
<ribasushi> mje: it's all part of this makefile, it's a good read rather clean
<mje> ignore - sorry
Jens suggested Config::AutoConf

  Cancel is not documented

ODBC 3.8:
http://msdn.microsoft.com/en-us/library/ee388581%28v=vs.85%29.aspx