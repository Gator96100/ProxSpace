use strict;

=encoding utf8

=head1 NAME

DBD::ODBC::FAQ - Frequently Asked Questions for DBD::ODBC

=head1 SYNOPSIS

  perldoc DBD::ODBC::FAQ

=head1 VERSION

($Revision$)

=head1 QUESTIONS

=head2 How do I read more than N characters from a Memo | BLOB | LONG field?

See LongReadLen in the DBI docs.

Example:

 $dbh->{LongReadLen} = 20000;
 $sth = $dbh->prepare("select long_col from big_table");
 $sth->execute;
 etc

=head2 What is DBD::ODBC?

=head2 Why can't I connect?

=head2 Do I need an ODBC driver?

=head2 What is the ODBC driver manager?

These, general questions lead to needing definitions.

=over 4

=item ODBC Driver

The ODBC Driver is the driver that the ODBC manager uses to connect
and interact with the RDBMS.  You B<DEFINITELY> need this to connect to
any database.  For Win32, they are plentiful and installed with many
applications.  For Linux/Unix, you can find a fairly comprehensive list
at L<http://www.unixodbc.org/drivers.html>.

=item ODBC Driver Manager

The ODBC driver manager is the interface between an ODBC application
(DBD::ODBC in this case) and the ODBC driver. The driver manager
principally provides the ODBC API so ODBC applications may link with a
single shared object (or dll) and be able to talk to a range of ODBC
drivers. At run time the application provides a connection string
which defines the ODBC data source it wants to connect to and this in
turn defines the ODBC driver which will handle this data source. The
driver manager loads the requested ODBC driver and passes all ODBC API
calls on to the driver. In this way, an ODBC application can be built
and distributed without knowing which ODBC driver it will be using.

However, this is a rather simplistic description of what the driver
manager does. The ODBC driver manager also:

* Controls a repository of installed ODBC drivers (on UNIX this is the
file odbcinst.ini).

* Controls a repository of defined ODBC data sources (on UNIX these are
the files odbc.ini and .odbc.ini).

* Provides the ODBC driver APIs (SQLGetPrivateProfileString and
SQLWritePrivateProfileString) to read and write ODBC data source
attributes.

* Handles ConfigDSN which the driver exports to configure data
sources.

* Provides APIs to install and uninstall drivers (SQLInstallDriver).

* Maps ODBC versions e.g. so an ODBC 2.0 application can work with an
ODBC 3.0 driver and vice versa.

* Maps ODBC states between different versions of ODBC.

* Provides a cursor library for drivers which only support
forward-only cursors.

* Provides SQLDataSources and SQLDrivers so an application can find
out what ODBC drivers are installed and what ODBC data sources are
defined.

* Provides an ODBC administrator which driver writers can use to
install ODBC drivers and users can use to define ODBC data sources.

The ODBC Driver Manager is the piece of software which interacts with
the drivers for the application.  It "hides" some of the differences
between the drivers (i.e. if a function call is not supported by a
driver, it 'hides' that and informs the application that the call is
not supported.  DBD::ODBC needs this to talk to drivers.

Under Win32, you usually get the ODBC Driver Manager as part of the
OS.  Under Unix/Linux you may have to find and build the driver
manager yourself. The two main driver managers for Unix are unixODBC
(L<http://www.unixodbc.org>) and iODBC (L<http://www.iodbc.org>).

B<It is strongly advised you get an ODBC Driver Manager before trying to
build DBD::ODBC unless you intend linking DBD::ODBC directly with your
driver.>

For a reasonable description of ODBC on Unix/Linux see
L<http://www.easysoft.com/developer/interfaces/odbc/linux.html>

=item DBD::ODBC

DBD::ODBC uses the driver manager to talk to the ODBC driver(s) on
your system.  You need both a driver manager and driver installed and
tested before working with DBD::ODBC.  You need to have a DSN (see
below) configured and B<TESTED> before being able to test DBD::ODBC.

=item DSN (Data Source Name)


The DSN is a way of referring to a particular driver and database by
any name you wish.  The DSN is usually a key to a list of attributes
the ODBC driver needs to connect to the database (e.g. ip address and
port) but there is always a key which names the driver so the driver
manager knows which driver to use with which data source. Do no
confuse DSNs with ODBC connection strings or DBI's "$data_source" (the
first argument to L<DBI/connect>.

The $data_source argument to DBI is composed of 'dbi:DRIVER:something_else'
where DRIVER is the name of the DBD driver you want to use (ODBC of
course for DBD::ODBC). The "something_else" for DBD::ODBC can be a DSN
name or it can be a normal ODBC connection string.

An ODBC connection string consists of attribute/value pairs separated
with semicolons (;). You can replace "something_else" above with a
normal ODBC connection string but as a special case for DBD::ODBC you can
just use the DSN name without the usual ODBC connection string prefix
of "DSN=dsn_name".

e.g.

=over

=item dbi:ODBC:DSN=fred

ODBC connection string using fred DSN

=item dbi:ODBC:fred

Same as above (a special case).

=item dbi:ODBC:Driver={blah blah driver};Host=1.2.3.4;Port=1000;

This is known as a DSN-less connection string for obvious reasons.

=back

=back

=head2 Where do I get an ODBC driver manager for Unix/Linux?

DBD::ODBC used to come bundled with a driver manager but this became
inconvenient when the driver manager was updated.

The two main ODBC Driver Managers for Unix are unixODBC (L<http://www.unixodbc/org>) and iODBC (L<http://www.iodbc.org>).

If you are running a packaged Linux like RedHat, Ubuntu, Fedora, Suse
etc etc you'll usually find it packaged with unixODBC and using the
package manager to install it is fairly straight forward. However,
make sure that if the driver manager is split into multiple packages
you install the development package as well as that contains the C
header files required by DBD::ODBC.

If you cannot find an ODBC Driver Manager package for your OS you can
download the source tar files for either of the driver managers above
and build it yourself.

=head2 How do I access a MS SQL Server database from Linux/UNIX?

You have loads of choices (in no particular order):

* using DBI::ProxyServer or DBD::Gofer. You'll need the former if you
  use transactions.

* using a commercial ODBC Driver or bridge like the ones from Easysoft
or Openlink.

* using FreeTDS an open source TDS library which includes an ODBC Driver.

* using DBD::Sybase and Sybase libraries.

=head2 How do I access a MS-Access database from Linux?

There are basically three choices:

* a commercial MS Access ODBC Driver like the one from Easysoft.

* a commercial ODBC Bridge like the ones from Easysoft or OpenLink.

* using mdbtools although as of writing it has not been updated since
June 2004, only provides read access and seems to be a little buggy.

=head2 Almost all of my tests for DBD::ODBC fail. They complain about not being able to connect or the DSN is not found.

Please, please test your configuration of ODBC and driver before
trying to test DBD::ODBC. Most of the time, this stems from the fact
that the DSN (or ODBC) is not configured properly. unixODBC comes with
a small program isql and iODBC comes with odbctest and you should use
these to test your ODBC configuration is working properly first.

=head2 I'm attempting to bind a Long Var char (or other specific type)
and the binding is not working.

The code I'm using is below:

	$sth->bind_param(1, $str, $DBI::SQL_LONGVARCHAR);
                                 ^^^

The problem is that DBI::SQL_LONGVARCHAR is not the same as
$DBI::SQL_LONGVARCHAR and that $DBI::SQL_LONGVARCHAR is an error!

It should be:

	$sth->bind_param(1, $str, DBI::SQL_LONGVARCHAR);

=head2 Does DBD::ODBC support Multiple Active Statements?

Multiple Active Statements (MAS) are concurrent statements created
from the same database handle which both have pending actions on them
(e.g. they both have executed a select statement but not retrieved all
the available rows yet).

DBD::ODBC does support MAS but whether you can actually use MAS is
down to the ODBC Driver.

By default MS SQL Server did not used to support multiple active
statements if any of them were select statements. You could get around
this (with caution) by changing to a dynamic cursor. There is a "hack"
in DBD::ODBC which can be used to enable MAS but you have to fully
understand the implications of doing so(see
L<DBD::ODBC/odbc_SQL_ROWSET_SIZE> and L<DBD::ODBC/odbc_cursortype>).

In MS SQL Server 2005, there is a new thing called MARS (Multiple
Active Result Sets) which allows multiple active select statements but
it has some nasty implications if you are also doing transactions.  To
enable MARS from DBD::ODBC add "MARS_Connection=Yes" to the connection
string as in:

  $h->DBI->connect('dbi:ODBC:DSN=mydsn;MARS_Connection=Yes;');

NOTE: Even though you may be using MS SQL Server 2005 if you are using
MS SQL Server drivers you will need to use the Native Client Driver or
a later MS SQL Server ODBC driver (2008 or later) to use MARS.

For other drivers it depends. I believe various Oracle ODBC drivers do
support multiple active statements as myodbc does.

Think carefully before using multiple active statements. It is
probably not portable and there is nearly always a better way of doing
it.

If anyone wants to report success with a particular driver and
multiple active statements I will collect them here.

Also see L<http://www.easysoft.com/developer/languages/perl/multiple-active-statements.html>

=head2 Why do I get "Datetime field overflow" when attempting to insert a
date into Oracle?

If you are using the Oracle or Microsoft ODBC drivers then you may get
the following error when inserting dates into an Oracle database:

  [Oracle][ODBC]Datetime field overflow. (SQL-22008)

If you do then check v$nls_parameters and v$parameter to see if you are
using a date format containing the RR format. e.g.,

  select * from v$nls_parameters where parameter = 'NLS_DATE_FORMAT'
  select * from v$parameter where name = 'nls_date_format'

If you see a date format like 'DD-MON-RR' (e.g., contains an RR) then
all I can suggest is you change the date format for your session as I
have never been able to bind a date using this format. You can do this
with:

  alter session set nls_date_format='YYYY/MM/DD'

and use any format you like but keep away from 'RR'.

You can find some test code in the file examples/rtcpan_28821.pl which
demonstrates this problem. This was originally a rt.cpan issue which
can be found at L<http://rt.cpan.org/Ticket/Display.html?id=28821>.

As an aside, if anyone is reading this and can shed some light on the problem
I'd love to hear from you. The technical details are:

  create table rtcpan28821 (a date)
  insert into rtcpan28821 values('23-MAR-62') fails

Looking at the ODBC trace, C<SQLDescribeParam> returns:

  data type: 93, SQL_TYPE_TIMESTAMP
  size: 19
  decimal digits: 0
  nullable: 1

and DBD::ODBC calls SQLBindParameter with:

  ValueType: SQL_C_CHAR
  ParameterType: SQL_TYPE_TIMESTAMP
  ColumnSize: 9
  DecimalDigits: 0
  Data: 23-MAR-62
  BufferLength: 9

=head2 Why do my SQL Server temporary objects disappear?

If you are creating temporary objects (e.g., temporary tables) in
SQL Server you find they have disappeared when you attempt to use
them. Temporary objects only have a lifetime of the session they
are created in but in addition, they cannot be created using
prepare/execute. e.g., the following fails:

  $s = $h->prepare('select * into #tmp from mytable');
  $s->execute;
  $s = $h->selectall_arrayref('select * from #tmp');

with "Invalid object name '#tmp'". Your should read
L<http://technet.microsoft.com/en-US/library/ms131667.aspx> which
basically says I<Prepared statements cannot be used to create
temporary objects on SQL Server 2000 or later...>. The proper way to
avoid this is to use the C<do> method but if you cannot do that then
you need to add the L<DBD::ODBC/odbc_exec_direct> attribute to your prepare as
follows:

  my $s = $h->prepare('select * into #tmp from mytable',
                      { odbc_exec_direct => 1});

See L<DBD::ODBC/odbc_exec_direct>.

=head2 Why cannot I connect to my data source on Windows 64?

If you are running a 32bit Perl on a 64bit Windows machine you will
need to be aware there are two ODBC administrators and you need to
create your DSNs with the right one. The ODBC Administrator you get to
from Control Panel, Administrative Tools, Data Sources is the 64bit
one and data sources created here will not be visible or useable from
32bit applications. The ODBC administrator you need to use for 32bit
applications can be found at X:\windows\syswow64\odbcad32.exe.

You can find more about this than you'd probably care to know
at http://www.easysoft.com/developer/interfaces/odbc/64-bit.html

=head2 How do I use DBD::ODBC with web servers under Win32.

=over 4

=item General Commentary re web database access

This should be a DBI faq, actually, but this has somewhat of an
Win32/ODBC twist to it.

Typically, the Web server is installed as an NT service or a Windows
95/98 service.  This typically means that the web server itself does
not have the same environment and permissions the web developer does.
This situation, of course, can and does apply to Unix web servers.
Under Win32, however, the problems are usually slightly different.

=item Defining your DSN -- which type should I use?

Under Win32 take care to define your DSN as a system DSN, not as a user
DSN.  The system DSN is a "global" one, while the user is local to a
user.  Typically, as stated above, the web server is "logged in" as a
different user than the web developer.  This helps cause the situation
where someone asks why a script succeeds from the command line, but
fails when called from the web server.

=item Defining your DSN -- careful selection of the file itself is important!

For file based drivers, rather than client server drivers, the file
path is VERY important.  There are a few things to keep in mind.  This
applies to, for example, MS Access databases.

1) If the file is on an NTFS partition, check to make sure that the Web
B<service> user has permissions to access that file.

2) If the file is on a remote computer, check to make sure the Web
B<service> user has permissions to access the file.

3) If the file is on a remote computer, try using a UNC path the file,
rather than a X:\ notation.  This can be VERY important as services
don't quite get the same access permissions to the mapped drive letters
B<and>, more importantly, the drive letters themselves are GLOBAL to
the machine.  That means that if the service tries to access Z:, the Z:
it gets can depend upon the user who is logged into the machine at the
time.  (I've tested this while I was developing a service -- it's ugly
and worth avoiding at all costs).

Unfortunately, the Access ODBC driver that I have does not allow one to
specify the UNC path, only the X:\ notation.  There is at least one way
around that.  The simplest is probably to use Regedit and go to
(assuming it's a system DSN, of course)
HKEY_LOCAL_USERS\SOFTWARE\ODBC\"YOUR DSN" You will see a few settings
which are typically driver specific.  The important value to change for
the Access driver, for example, is the DBQ value.  That's actually the
file name of the Access database.

=back

=head2 How do I connect without DSN

The ability to connect without a full DSN was introduced in version 0.21.

Example (using MS Access):

  my $DSN = 'driver=Microsoft Access Driver(*.mdb);dbq=\\\\cheese\\g$\\perltest.mdb';
  my $dbh = DBI->connect("dbi:ODBC:$DSN", '','') or die "$DBI::errstr\n";

The above sample uses Microsoft's UNC naming convention to point to
the MSAccess file (\\cheese\g$\perltest.mdb).  The dbq parameter tells
the access driver which file to use for the database.

Example (using MSSQL Server):

  my $DSN = 'driver={SQL Server};Server=server_name;database=database_name;uid=user;pwd=password;';
  my $dbh = DBI->connect("dbi:ODBC:$DSN") or die "$DBI::errstr\n";

=head2 Why do I get data truncated error from SQL Server when inserting with parameters?

Please see "Why am I getting errors with bound parameters" below which
collects all parameter issues together in one FAQ item.

=head2 Why do I get invalid value for cast specification (22018) from SQL Server when inserting with parameters?

Please see "Why am I getting errors with bound parameters" below which
collects all parameter issues together in one FAQ item.

=head2 Why do I get strange results with SQL Server and named parameters?

If you are using a MS SQL Server driver and named parameters to
procedures be very careful to use then in the same order they are
defined in the procedure. i.e., if you have a procedure like this:

  create procedure test
        @param1 varchar(50),
        @param2 smallint
  as
  begin
  ..
  end

then ensure if you call it using named parameters you specify them in
the same order they are declared:

  exec test @param1=?,@param2=?

and not

  exec test @param2=?,@param1=?

The reason for this is that all SQL Server drivers we have seen
describe procedures parameters in the order they are declared and
ignore the order they are used in the SQL. If you specify them out of
order DBD::ODBC will get details on p1 which are really for p2
etc. This can lead to data truncation errors and all sorts of other
problems it is impossible for DBD::ODBC to spot or workaround.

=head2 Why do I get "Numeric value out of range" when binding dates in Oracle?

Also see "Why do I get "Datetime field overflow" when attempting to insert a
date into Oracle?".

Here is some example code binding dates; some work, some don't, see comments.

  use DBI;
  use strict;

  # table is "create table martin (a date, b int)"

  my $h = DBI->connect;

  $h->do(q{alter session set nls_date_format='DD-MON-YY'});

  my $s = $h->prepare(q{select * from v$nls_parameters where parameter = 'NLS_DATE_FORMAT'});
  $s->execute;
  print DBI::dump_results($s);

  my $date = '30-DEC-99';
  my $dateodbc = qq/{ d '1999-12-30'}/;

  # the following works ok - resulting in 2099-12-30 being inserted
  $h->do(qq{insert into martin values ('$date', 1)});

  # the following works resulting in 1999-12-30 being inserted
  $h->do(qq{insert into martin values ($dateodbc, 2)});

  # fails
  eval {
      my $s = $h->prepare(q{insert into martin values(?,3)});
      $s->bind_param(1, $date);
      # fails
      # Numeric value out of range: invalid character in date/time string (SQL-22003)
      $s->execute;
  };

  # works resulting in 2099-12-30 being inserted
  eval {
      my $s = $h->prepare(q{insert into martin values(?,4)});
      $s->bind_param(1, $date, DBI::SQL_VARCHAR);
      $s->execute;
  };

  # works resulting in 1999-12-30 being inserted
  eval {
      my $s = $h->prepare(q{insert into martin values(?,5)});
      $s->bind_param(1, $dateodbc);
      $s->execute;
  };

In general, when using an ODBC driver you should use the ODBC syntax
for dates, times and timestamps as those are the only formats an ODBC
has to support.

In the above case with Oracle, the date parameter is described as a
SQL_TYPE_DATE SQL type so by default DBD::ODBC binds your parameter as
a SQL_TYPE_DATE. If you use '30-DEC-99' then that means the C type is
SQL_CHAR and the SQL type is SQL_TYPE_DATE so the driver is forced to
parse the date before sending it to Oracle (that would mean knowing
what your NLS_DATE_FORMAT is and it would also mean knowing all the
magic special characters Oracle can use to define date formats).

If you override the bind type to SQL_VARCHAR then the driver sees
SQL_CHAR => SQL_VARCHAR, nothing to do and hence Oracle itself does
the translation - that is why the SQL_VARCHAR works.

=head2 CWB0111 error with System i Access ODBC Driver

The full error this relates to is:

[unixODBC][IBM][System i Access ODBC Driver]Column 1: CWB0111 - A buffer passed to a system call is too small to hold return data (SQL-22018)

The iSeries ODBC driver looks at your environment and decides that if
you have UTF-8 set it will encode data returned from the database in
UTF-8.

e.g., LC_CTYPE=fr_FR.UTF-8

If you then select data from your database containing non-ASCII
characters e.g., accented characters the iSeries ODBC driver will
encode the data in UTF-8. UTF-8 encoding increases the size of strings
containing characters with codes > 127.

DBD::ODBC uses SQLDescribeCol and SQLColAttribute ODBC calls to work
out the size of the columns you are retrieving and allocate space for
them. As the ODBC API specifies the sizes returned are on bytes when
the driver says a string column is N is size DBD::ODBC allocates N+1
(for NULL) bytes. If the driver then encodes N characters in UTF-8 the
size will be too big to fit into DBD::ODBC's buffer and you will get
the error above. This is most often seen with char(N) columns as the
trailing spaces are returned by the driver so you are bound to
overflow the buffer as soon as a non-ASCII characters is found.

What are your possible solutions?

You can attempt to trim the data to leave room for the encoding.
e.g., RTRIM(column_name) in your select on char(N) columns but this is
a poor choice and only going to work in a few circumstances.

You can increase the sizes of your columns in the database but this is
another hack.

You can rearrange your SQL to cast the columns in question to larger
types.

Remove UTF-8 from your locale. This is the best solution as it is
guaranteed to stop this error but if you have data which cannot be
represented in 8 bit characters this won't help.

=head2 "ConnectionWrite (send())" error and bind parameters

The following error can happen when using more than 2097 bind
parameters in a single query with SQL Server 2000:

 [Microsoft][ODBC SQL Server Driver][DBNETLIB]ConnectionWrite (send()).
 (SQL-01000) [state was 01000 now 08S01]
 [Microsoft][ODBC SQL Server Driver][DBNETLIB]General network error.
 Check your network documentation. (SQL-08S01)

This error is most likely due to a bug in the Microsoft SQL Server
ODBC driver as it fails for some versions of the driver and not
others. It is known to fail for version 2000.85.1132.00

See bug report https://rt.cpan.org/Public/Bug/Display.html?id=49061
for more details.

=head2 SQL query length limited to about 65500 characters in SQL Server 2000

When using bind parameters and a query longer than about 65500
characters the query will fail with some versions of the SQL Server
2000 ODBC driver. The error message from the server can vary. Below is
an example:

 [Microsoft][ODBC SQL Server Driver][SQL Server]Invalid column name
 'TES[...]P1I'. (SQL-42S22) [state was 42S22 now 42000]
 [Microsoft][ODBC SQL Server Driver][SQL Server]Statement(s) could not
 be prepared. (SQL-42000)

Removing the use of binding will allow queries that are longer than
65500 characters.

This bug is known to affect Microsoft SQL Server ODBC driver version
2000.85.1132.00.

See bug report https://rt.cpan.org/Public/Bug/Display.html?id=49065

=head2 HY009, "invalid length or pointer" from SQLite

See rt 52651 at http://rt.cpan.org/Public/Bug/Display.html?id=52651.

During connection if you get a HY009 "invalid length or pointer" error
it is a bug in SQLSetConnectAttr in SQLite and you will need a version
at least 0.85pre1.

=head2 Where do I get the latest MDAC Development Kit?

MS keep moving this around. If you want to build DBD::ODBC yourself
from source you'll need the latest Microsoft Data Access Components
(MDAC) Software Development Kit. You can get it as part of the Platform
Development Kit, with some of the Visual Studio versions and occasionally
from:

http://msdn.microsoft.com/en-us/data/aa937730.aspx

where in April 2010 it listed the "Microsoft Data Access Componetns (MDAC)
2.8 Software Development Kit.

=head2 Why does DBD::ODBC fail to compile with missing definitions for SQLLEN/SQLULEN?

This happens because Microsoft changed their headers to add SQLLEN/SQLULEN
types and your C headers are probably out of date. As DBD::ODBC needs
to use these types you'll need an updated MDAC Development Kit. See
" Where do I get the latest MDAC Development Kit?".

=head2 Why do I get errors with bound parameters and MS SQL Server?

See the question "Why do I get data truncated error from SQL Server
when inserting with parameters?" above. These errors are often because
of bugs in the MS SQL Server ODBC driver in its SQLBindParameter
implementation and can be worked around by specifying a type at bind
time.

e.g.,

Instead of:


  my $s = prepare(q/some sql with parameters/);
  $s->execute($param1, $param2);

try:

  my $s = prepare(q/some sql with parameters/);
  $s->bind_param(1, $param1, {TYPE => SQL_VARCHAR});
  $s->bind_param(2, $param2, {TYPE => SQL_VARCHAR});
  $s->execute;

See https://connect.microsoft.com/SQLServer/feedback/details/527188/paramater-datatype-lookup-returns-incorrectly and rt ticket 50852.

=head2 Why does my script pause for a while whenever my statement handle is destroyed (goes out of scope)?

The symptom is that sometimes when your statement handle goes out of
scope and is hence destroyed your script pauses for a while. If you
are using MS SQL Server and certain MS SQL Server ODBC Drivers this
can happen when you issue a select which would return a lot of rows
but you don't fetch them all.

The problem is that the TDS protocol (normally, without Multiple
Active Statement support, or MARS) sends all the result-set down the
socket until it is consumed by the client end. When your statement
handle is destroyed with pending results the ODBC Driver needs to read
all the results to clear the socket. In reality MS SQL Server will
only write so many rows at a time to the socket depending on its
buffer size and will occasionally look at the socket for new requests
so it is possible for ODBC Drivers which support SQLCancel to reduce
the number of rows sent by using DBI's cancel method. In this way the
statement destruction is speeded up since fewer rows you don't need
are sent.  See DBI's cancel method and if you destroy a statement
handle with pending results, call cancel before destruction.

However, you are best not selecting rows you have no intention of
retrieving.

See cancel_big_fetch.pl in the DBD::ODBC examples dir. NOTE: more recent
MS SQL Server drivers are better in this respect and sometimes the test
script cancel_big_fetch.pl shows no difference.

=head2 Why does my backup/restore/some_other_procedure in MS SQL Server not complete?

MS SQL Server batches up results in a procedure. A result may be the
output of a print or a select or in some cases even an insert/update
(see SET NOCOUNT ON|OFF). If you attempt to call a procedure using the
C<do> method and it outputs results (e.g., a print statement saying
the % completed) the procedure probably will not fully
complete. Instead you should do the following:

  $sth-prepare(call to my procedure);
  $sth->execute;
  do {
    while (my @row = $sth->fetchrow_array()) {
      # do stuff here
    }
  } while ($sth->{odbc_more_results});
  # do not forget to check $sth->err here if not using RaiseError as
  # the outer while loop will stop when there are no more results OR
  # if an error occurs.

=head2 Why do I get "The data types ntext and varchar are incompatible in the equal to operator"?

Or "The data types ntext and nvarchar(max) are incompatible in the
equal to operator".

MS SQL Server does not like equality comparisons with ntext columns.
You can get this error without using any Perl or DBD::ODBC simply by doing:

  select * from mytable where ntext_column = 'hello'

You unfortunately need to change your SQL to:

  select * from mytable where CAST(ntext_column AS nvarchar(max)) = 'hello'

=head2 Why are my integers returned as decimals?

If you are using the MS SQL Server ODBC driver and get
integers/booleans back as apparently decimals e.g. 0.00 instead of 0 and
integer primary keys as nn.nn you've probably either:

=over

=item enabled regional settings in the ODBC DSN setup (called "use regional settings with outputting..."

=item added "Regional=Yes" to your connection string.

The MS SQL Server ODBC Driver regional settings are massively flawed
and break lots of applications - turn it off.

=back

=head2 Why does Connect call fail on Ubuntu with a "undefined symbol SQLxxx" error?

Sometimes SQLxxx is SQLAllocHandle or SQLFetch but it could almost be
any ODBC API.

Did you build DBD::ODBC against iODBC? Some versions of Ubunutu Linux
seem to install the libiodbc shared object without a libiodbc.so
symbolic link. The key giveaway when you build DBD::ODBC is a warning like
this:

  Note (probably harmless): No library found for -liodbc.so

You can fix this manually by creating a symbolic link something like this:

  sudo ln /usr/lib/libiodbc.so.2 /usr/lib/libiodbc.so

but to be honest this just moved the problem on for me and I've never got
iODBC working on Ubuntu.

I suggest you remove iODBC and installing the unixodbc, unixodbc-dev and
unixodbc-bin packages.

=head2 Why does Connect fail with "Option type out of range"

You are probably setting an ODBC connection option like
odbc_SQL_ROWSET_SIZE in the connect method. The problem is that some
options can be set in ODBC with SQLSetConnectOption but not retrieved
(silly but that is how some of the driver managers work). In the past
this did not matter but a small bug in DBI introduced years ago causes
attribute values to be fetched.

You need to get a DBI release newer than 1.615 or revision 14463 from
the DBI subversion repository. The change was:

  --- dbi/trunk/DBI.pm	(original)
  +++ dbi/trunk/DBI.pm	Thu Oct  7 02:45:05 2010
  @@ -717,7 +717,8 @@
   		$dbh->{$a} = delete $apply->{$a};
   	    }
   	    while ( my ($a, $v) = each %$apply) {
  -		eval { $dbh->{$a} = $v } or $@ && warn $@;
  +		eval { $dbh->{$a} = $v }; # assign in void context to avoid re-FETCH
  +                warn $@ if $@;
   	    }
   	}

=head2 Why do I get undefined symbol my_snprintf?

It is my fault. Basically, I changed DBD::ODBC to use Devel::PPPort's
my_snprintf instead of sprintf (for safety) but because of the way DBI
includes ppport.h (as dbipport.h) I cannot override it in DBD::ODBC.
This should now be fixed in DBI but I cannot retrofit it so if you
get this error you need to upgrade DBI to at least version 1.609.
Sorry, some things are as they are.

From DBD::ODBC 1.26_1 a requirement is DBI 1.609 so this should not be
an issue but the 1.24 and 1.25 series DBD::ODBC did not have this
requirement.

=head2 Why can I appear to insert more than 255 chrs into a MS Access text column but when I read them back I only get 255 chrs?

The simple answer is that MS Access only supports 255 characters in a
text column. You can see this if you create a table with a text column
then examine the PRECISION attribute (see DBI) and it returns 255.

Unfortunately some versions of the MS Access ODBC driver silently
truncate the data instead of issuing a data truncation error so you
are not aware of the truncation until you read it back.

Someone pointed out you can insert more than 255 characters into a MS
Access text column with DBD::ADO but I believe if you look at the
column types after creating the table with DBD::ADO the text column is
really a memo column.

=head2 Why am I getting errors with bound parameters?

There are various problems with parameter binding in ODBC Drivers most
of them down to bugs in the ODBC drivers. I created this FAQ to try
and bring them all together in one place and other FAQ entries point
at this one as a number of them boil down to a single problem.

DBD::ODBC used to (many many versions ago) bind all parameters as
SQL_VARCHAR and this mostly works because a SQL_VARCHAR can almost
always be converted to any other SQL type. However, because of bugs in
some ODBC drivers, additional SQL types which work in mysterious ways
(like varchar(max) in MS SQL Server) and dates, DBD::ODBC was changed
to ask the ODBC Driver (C<SQLDescribeParam>) about parameters before
binding them.

There are a few things to note first:

=over

=item default bind type

Some ODBC Drivers do not support C<SQLDescribeParam> (e.g. freeTDS) and
in those cases DBD::ODBC reverts to its old behaviour of binding
everything as a SQL_VARCHAR or SQL_WVARCHAR (UNICODE build). In some
rare cases the default bind type might not be what you want.

In addition, if C<SQLDescribeParam> is supported but fails the default
bind type is used.

=item overriding the default bind type

You can always override the default bind type used when
C<SQLDescribeParam> is not supported using odbc_default_bind_type.

=item forcing a bind type

Sometimes the ODBC Driver can support C<SQLDescribeParam> but get the
answer wrong e.g., "select myfunc(?) where 1 = 1)" often causes a
problem because the parameter does not correspond to a real column in
a table. In these cases you can use odbc_force_bind_type to stop
DBD::ODBC calling C<SQLDescribeParam> and use the specified type
instead. However, adding TYPE => xxx to the bind_param call is nearly
always better (as it is more specific) and always overrides
odbc_force_bind_type.

=item specifying a bind type on the bind_param call

In all cases this overrides anything else that DBD::ODBC might do
and bare in mind parameter bind types set in this way are "sticky" (see
DBI). This is usually the best method unless you prefer to use a
cast in your SQL.

=back

Now to the specific problems:

=over

=item data truncated error

DBD::ODBC attempts to use the ODBC API C<SQLDescribeParam> to obtain
information about parameters in parameterised SQL. e.g.,

  insert into mytable (column1) values(?)

The C<?> is a parameter marker. You supply the parameter value (in
this case parameter 1) with a call to the C<bind_param> method or by
adding the parameter to the C<execute> method call. When DBD::ODBC
sees the parameter marker in the SQL it will call C<SQLDescribeParam>
to obtain information about the parameter size and type etc (assuming
your ODBC driver supports C<SQLDescribeParam>).

When you call C<SQLDescribeParam> in the MS SQL Server ODBC driver the
driver will scan your SQL attempting to discover the columns in your
database the parameters align with. e.g., in the above case the
parameter to be bound is linked with "column1" so C<SQLDescribeParam>
should return information about "column1". The SQL Server ODBC driver
finds information about "column1" (in this example) by creating SQL such
as:

  select column1 from mytable where 1 = 2

then looking at the column details. Unfortunately, some SQL confuses
SQL Server and it will generate SQL to find out about your parameters
which examines the wrong columns and on rare occasions it may even
generate totally incorrect SQL. The test case F<t/rt_39841.t>
demonstrates a couple of these.

The upshot of this is that DBD::ODBC is sometimes lied to about
parameters and will then bind your parameters incorrectly. This can lead
to later errors when C<execute> is called. This happens most commonly
when using parameters in SQL with sub-selects. For example:

  create table one (a1 integer, a2 varchar(10))
  create table two (b1 varchar(10), b2 varchar(20))

  insert into one values(1, 'aaaaaaaaaa')
  insert into two values('aaaaaaaaaa','bbbbbbbbbbbbbbbbbbbb')

  select b1, (select a2 from one where a2 = b1) from two where b2 = ?

  param 1 bound as 'bbbbbbbbbbbbbbbbbbbb'

Clearly in this example, the one and only parameter is for two.b2 which
is a varchar(20) but when SQL Server rearranges your SQL to describe
the parameter it issues:

  select a2 from one where 1 = 0

and DBD::ODBC is told the parameter is a VARCHAR(10). In DBD::ODBC
1.17 this would then lead to a data truncation error because parameter
1 would be bound as 'bbbbbbbbbbbbbbbbbbbb' but with a column size of
10 as that is what C<SQLDescribeParam> returned. DBD::ODBC 1.17_1 (and
later) works around this problem for VARCHAR columns because it is
obvious a VARCHAR parameter of length 20 cannot have a column size of
10 so the column size is increased to the length of the parameter.

=item invalid value for the cast specification (22018)

See the previous item as this follows on from that.

See L<http://support.microsoft.com/kb/269011> on the microsoft web
site for a bug you may have hit.

In Perl the most common reason for this is that you have bound column
data in SQL which does not match the column type in the database and
the ODBC driver cannot perform the necessary conversion. DBD::ODBC
mostly binds all column data as strings and lets the ODBC driver
convert the string to the right column type. If you supply a string
which cannot be converted to the native column type you will get this
error e.g., if you attempt to bind a non-datetime string to a datetime
column or a non-numeric string to a numeric column.

A more difficult error (from that above in the previous item) can
occur when SQL Server describes the parameter as totally the wrong
type. The first example in F<t/rt_39841.t> demonstrates this. SQL
Server describes a VARCHAR parameter as an integer which DBD::ODBC has
little choice to believe but when something like 'bbbbbbbbbb' is bound
as an integer, SQL Server will then return an error like "invalid
value for cast specification". The only way around this is to
specifically name the parameter type. e.g.,

  create table one (a1 integer, a2 varchar(20))
  create table two (b1 double precision, b2 varchar(8))

  insert into one values(1, 'aaaaaaaaaa')
  insert into two values(1, 'bbbbbbbb')

  select b1, ( select a2 from one where a1 = b1 ) from two where b2 = ?

  param 1 bound as 'bbbbbbbbbb'

Clearly parameter 1 is a varchar(8) but SQL Server rearranges the SQL to:

  select a1 from one where 1 = 2

when it should have run

  select b2 from two where 1 = 2

As a result parameter 1 is described as an integer and this leads to the
problem. To workaround this problem you would need to bind parameter 1
naming the SQL type of the parameter using something like:

  use DBI qw(:sql_types);

  bind_param(1, 'bbbbbbbbbb', SQL_VARCHAR);

as omitting SQL_VARCHAR will cause DBD::ODBC to use the type
C<SQLDescribeParam> returned.

See https://connect.microsoft.com/SQLServer/feedback/details/527188/paramater-datatype-lookup-returns-incorrectly and rt ticket 50852.

=item problems with named parameters

If you are using a MS SQL Server driver and named parameters to
procedures be very careful to use then in the same order they are
defined in the procedure. i.e., if you have a procedure like this:

  create procedure test
        @param1 varchar(50),
        @param2 smallint
  as
  begin
  ..
  end

then ensure if you call it using named parameters you specify them in
the same order they are declared:

  exec test @param1=?,@param2=?

and not

  exec test @param2=?,@param1=?

The reason for this is that all SQL Server drivers we have seen
describe procedures parameters in the order they are declared and
ignore the order they are used in the SQL. If you specify them out of
order DBD::ODBC will get details on p1 which are really for p2
etc. This can lead to data truncation errors and all sorts of other
problems it is impossible for DBD::ODBC to spot or workaround.

=item Argument data type varchar is invalid for argument N of xxx function

e.g.,

  [SQL Server]Argument data type varchar is invalid for argument 2 of dateadd function.

Some functions need specific argument types and as explained above
some drivers have a lot of difficulties working out parameter types in
function calls.

In this example (also from the DBIx::Class test code) the SQL was like:

  SELECT DATEADD(hour, ?, me.date_created) FROM mytable me where me.id = ?

The second argument to dateadd needs to be an integer. There are 2 ways
around this:

=over

=item bind parameter 1 as an SQL_INTEGER

=item  CAST(? as integer)

=back

=item other bugs in ODBC Drivers with parameter support

See the question "Why do I get data truncated error from SQL Server
when inserting with parameters?" above. These errors are often because
of bugs in the MS SQL Server ODBC driver in its SQLBindParameter
implementation and can be worked around by specifying a type at bind
time.

e.g.,

Instead of:


  my $s = prepare(q/some sql with parameters/);
  $s->execute($param1, $param2);

try:

  my $s = prepare(q/some sql with parameters/);
  $s->bind_param(1, $param1, {TYPE => SQL_VARCHAR});
  $s->bind_param(2, $param2, {TYPE => SQL_VARCHAR});
  $s->execute;

See https://connect.microsoft.com/SQLServer/feedback/details/527188/paramater-datatype-lookup-returns-incorrectly and rt ticket 50852.

=item example of where overriding parameter type is required

Here is an example sent to me from someone (wesm) using DBIx::Class
illustrating a problem with bound parameters in a complex bit of SQL
and date columns:

    use DBI qw(:sql_types);
    use strict;
    use warnings;
    my $h = DBI->connect();

    eval{ $h->do(q/DROP TABLE odbctest/) };

    $h->do(q/CREATE TABLE odbctest (
       id integer NOT NULL IDENTITY (1,1),
       name nvarchar(50) NULL,
       adate date NULL )/);

    my $s = $h->prepare(q/
    set identity_insert odbctest on;
    insert into odbctest
       (id, name, adate)
       values (?,?,?);

    set identity_insert odbctest off;
    select scope_identity();
    /);

    my $bug
       = undef;        # fails
       #= '2011-03-21'; # works
    my @values = (
       [ 1000,     2000, ],
       [ 'frew',   'wes', ],
       [ $bug,    '2009-08-10', ],
    );

    my $i = 1; my $tuple_status;
    $s->bind_param_array($i++, $_) for @values;
    $s->execute_array({ArrayTupleStatus => $tuple_status});

    $s = $h->prepare(q/select * from odbctest where id = ?/);
    foreach (1000, 2000) {
        $s->execute($_);
        print DBI::dump_results($s);
    }

When I first ran this with SQL Server native client (pre native client 10)
on Windows I got

    DBD::ODBC::st execute_array failed: [Microsoft][SQL Native Client]Syntax error,  permission violation, or other nonspecific error (SQL-42000) [err was 1 now 2000

The call to C<SQLDescribeParam> fails because the driver cannot rearrange
the SQL into a select allowing it to identify the column. DBD::ODBC
then falls back on the default parameter bind type and it still
fails. When you switch to the native client 10 driver (newer) it fails
with optional feature not implemented. Now I'm only guessing here but
the date column type was added in SQL Server 2008 and I'm guessing
when it was added they forgot to add something in the driver for full
date support.

If you use native client 10 and change the insert code to:

    my @values = (
       [ 1000,     2000, ],
       [ 'frew',   'wes', ],
       [ $bug,    '2009-08-10', ],
    );
    my @types = (
    	SQL_VARCHAR, SQL_VARCHAR, SQL_DATE);

    my $i = 1; my $tuple_status;
    $s->bind_param_array($i++, $_, {TYPE => $types[$i-2]}) for @values;
    $s->execute_array({ArrayTupleStatus => $tuple_status});

you workaround the problem.

It is possible when you read this now that DBIx::Class has worked
around this problem.

=back

=head2 Why do I get data truncated errors with type_info and Firebird ODBC Driver?

The Firebird ODBC driver from the open source Firebird project version
02.01.0100 (as reported in ODBC via SQLGetInfo) seems to report the
length of the TYPE_NAME field for types -9 'VARCHAR(x) CHARACTER SET
UNICODE_' and -10 'BLOB SUB_TYPE TEXT CHARACTER SET ' as 34 but then
attempt to write 36 characters to them.

Unfortunately this is an error via DBI and due to the way type_info
is implemented (where it retrieves all the types the first time you
query any type) it stops you querying any type even those which are
not -9 or -10. Unless you need the TYPE_NAME field this should not matter
to you in which case you can set LongTruncOk before retrieving type_info:

  my $ti;
  {
    local $dbh->{LongTruncOk} = 1;
    $ti = $dbh->type_info_all;
  }

You will need to do something similar if you use the statements
attributes like TYPE the first time you use them.

I reported this issue at http://tracker.firebirdsql.org/browse/ODBC-122.

=head2 Why do I get "symbol lookup error for SQLAllocHandle" on Ubuntu/Debian?

You've probably got iODBC installed and the Makefile.PL found it before
unixODBC but on some Ubuntu and Debian distributions iODBC is not installed
with the symbolic link libiodbc.so e.g., /usr/lib contains

lrwxrwxrwx 1 root root     22 2011-01-04 20:00 libiodbcinst.so.2 -> libiodbcinst.so.2.1.18
-rw-r--r-- 1 root root  67140 2009-11-11 00:42 libiodbcinst.so.2.1.18
lrwxrwxrwx 1 root root     18 2011-01-04 20:00 libiodbc.so.2 -> libiodbc.so.2.1.18
-rw-r--r-- 1 root root 305108 2009-11-11 00:42 libiodbc.so.2.1.18

but no libiodbc.so. You could create the symbolic link:

cd /usr/lib
sudo ln -s libiodbc.so.2 libiodbc.so

however, you'll probably have other problems so better to use
unixODBC. Ensure you've installed unixodbc and unixodbc-dev packages
and re-run Makefile.PL with the -x argument to prefer unixODBC.

=head2 How do I set the application and workstation names for MS SQL Server?

MS SQL Server supports 2 additional connection attributes which you
can use to set application name and the workstation name:

B<APP> specifies the application name recorded in the program_name
column in master.dbo.sysprocesses.

B<WSID> sets the workstation name recorded in the hostname column in
master.dbo.sysprocesses.

To set these add these attributes to the call to DBIs connect like this:

  my $h = DBI->connect('dbi:ODBC:DSN=mydsn;APP=appname;WSID=wsname',
                       'dbuser', 'dbpass');

=head2 Why do I get "The specified DSN contains an architecture mismatch between the Driver and Application" on Windows?

You've got a 64 bit Windows.

Your attempting to connect to a SYSTEM DSN.

You are trying to connect to a 64bit SYSTEM DSN from a 32 bit
application or vice versa. See my initial experience
http://www.martin-evans.me.uk/node/81.

More confusing is if you use the data_sources method, that calls
SQLDataSources and the list returned matches the architecture of your
Perl binary and yet when you attempt to connect to a DSN for the
wrong architecture you get this error instead of the more sensible
(and usual) data source not found.

NOTE: User DSNs don't exhibit this - they just seem to pick the right
driver.

See also http://www.easysoft.com/developer/interfaces/odbc/64-bit.html

=head2 Why does my transaction get committed when I disable AutoCommit?

If you are doing something like this:

  {local $h->{AutoCommit} = 0;
   $h->do(q/insert into mje values(1)/);
  }

then what really happens is AutoCommit is disabled at the start of the
block and when the block is exited AutoCommit is re-enabled. In ODBC
enabling AutoCommit will commit any outstanding transaction. Don't do
this. Instead, either rollback or commit at the end of the block or
leave AutoCommit alone and call begin_work/commit/rollback yourself in
the block.

=head2 Why do I get the wrong row count from execute_for_fetch?

Some drivers don't return the correct value from SQLRowCount when
binding arrays of parameters. e.g., freeTDS 8 and 0.91 seems to return
a 1 for each batch. e.g., if you run a SQL insert to insert 15 rows
and pass an array of 15 rows to execute_array with the default array
size of 10 it takes 2 batches to execute all the parameters and
freeTDS will return 1 row affected for each batch hence returns 2
instead of 15.

See rt 75687.

=head2 Why are my pound signs (£), dashes and quotes (and other characters) returned garbled

The first question in response is why do you think what you got back was incorrect? Did you print the data to a terminal and it looks wrong, or perhaps sent it to a browser in a piece of CGI or even wrote it to a file? The mantra you need to stick to is decode all input to Perl and encode all output but DBD::ODBC does the decoding of data retrieved from the database for you.

The classic case I keep seeing I've repeated here because it illustrates the most common problem. Database is MS SQL Server, data is viewed in the management console and looks good but when retrieved via DBD::ODBC it looks wrong. The most common cause of this is the data you've retrieved is stored as unicode in Perl and you output it to somewhere without encoding it first with an encoding appropriate for the output e.g., you printed it from a windows terminal without setting the STDOUT encoding to cp1252 (or whatever your codepage in your terminal is). The first thing I'd suggest is to print the data with Data::Dumper and if any of the output contains \x{NNNN} your data is unicode (there are other ways like using DBI's data_string_desc utility method or Encode's is_utf8).

Bear in mind that in a unicode build of DBD::ODBC (the default on Windows) all string data is retrieved as unicode. When you output your unicode data anywhere you need to encode it with Encode::encode e.g.,

binmode(STDOUT, ":encoding(cp1252)");

Just because you think you are working in a single codepage does not mean the data you retrieve will be returned as single byte characters in that codepage. DBD::ODBC (in a unicode build) retrieves all string data as wide (unicode) characters and most ODBC drivers will convert the codepage data returned by the database to unicode. For example, your column is windows-1252 codepage and contains a euro symbol which is character 0xA3. When retrieved by DBD::ODBC, the ODBC driver will convert this to unicode character 0x20ac. If you output this without encoding you'll likely see rubbish.

If you are absolutely sure you are using a single code page and don't want to be bothered with unicode, look up the odbc_old_unicode attribute but better still, rebuild DBD::ODBC without unicode support using:

perl Makefile.PL -nou

=head2 Does DBD::ODBC support the new table valued parameters?

Not yet. Patches welcome.

=head2 Why do I get "COUNT field incorrect or syntax error (SQL-07002)"?

In general this error is telling you the number of parameters bound or
passed to execute does not match the number of parameter markers in
your SQL. However, this can also happen if you attempt to use too many
parameters.

For instance, for MS SQL Server
(http://msdn.microsoft.com/en-us/library/ms143432.aspx) the maximum is
2100.

=head2 Why are my column names truncated to 30 characters when using freeTDS?

You should note this is only an observed answer. The person who
reported this to me was using MS SQL Server 2008. If he set TDS
protocol 6.0, 9.0 or 10.0 his column names were truncated to 30
charatcers. If he specified TDS protocol 7.0 or 8.0 his column names
were not truncated. We guessed his server did not support protocols
9.0 or 10.0 and fall back to 6.0 where column names are restricted to
30 characters.

=head1 AUTHOR

Parts of this document were written by Tim Bunce,
Jeff Urlwin and Martin J. Evans.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.7 or,
at your option, any later version of Perl 5 you may have available.


=cut

