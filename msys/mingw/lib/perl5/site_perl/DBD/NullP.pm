use strict;
{
    package DBD::NullP;

    require DBI;
    require Carp;

    our @EXPORT = qw(); # Do NOT @EXPORT anything.
    our $VERSION = "12.014715";

#   $Id: NullP.pm 14714 2011-02-22 17:27:07Z Tim $
#
#   Copyright (c) 1994-2007 Tim Bunce
#
#   You may distribute under the terms of either the GNU General Public
#   License or the Artistic License, as specified in the Perl README file.

    our $drh = undef;	# holds driver handle once initialised

    sub driver{
	return $drh if $drh;
	my($class, $attr) = @_;
	$class .= "::dr";
	($drh) = DBI::_new_drh($class, {
	    'Name' => 'NullP',
	    'Version' => $VERSION,
	    'Attribution' => 'DBD Example Null Perl stub by Tim Bunce',
	    }, [ qw'example implementors private data']);
	$drh;
    }

    sub CLONE {
        undef $drh;
    }
}


{   package DBD::NullP::dr; # ====== DRIVER ======
    our $imp_data_size = 0;
    use strict;

    sub connect { # normally overridden, but a handy default
        my $dbh = shift->SUPER::connect(@_)
            or return;
        $dbh->STORE(Active => 1);
        $dbh;
    }


    sub DESTROY { undef }
}


{   package DBD::NullP::db; # ====== DATABASE ======
    our $imp_data_size = 0;
    use strict;
    use Carp qw(croak);

    # Added get_info to support tests in 10examp.t
    sub get_info {
        my ($dbh, $type) = @_;

        if ($type == 29) {      # identifier quote
            return '"';
        }
        return;
    }

    # Added table_info to support tests in 10examp.t
    sub table_info {
        my ($dbh, $catalog, $schema, $table, $type) = @_;

        my ($outer, $sth) = DBI::_new_sth($dbh, {
            'Statement'     => 'tables',
        });
        if (defined($type) && $type eq '%' && # special case for tables('','','','%')
                grep {defined($_) && $_ eq ''} ($catalog, $schema, $table)) {
            $outer->{dbd_nullp_data} = [[undef, undef, undef, 'TABLE', undef],
                                        [undef, undef, undef, 'VIEW', undef],
                                        [undef, undef, undef, 'ALIAS', undef]];
        } elsif (defined($catalog) && $catalog eq '%' && # special case for tables('%','','')
                grep {defined($_) && $_ eq ''} ($schema, $table)) {
            $outer->{dbd_nullp_data} = [['catalog1', undef, undef, undef, undef],
                                        ['catalog2', undef, undef, undef, undef]];
        } else {
            $outer->{dbd_nullp_data} = [['catalog', 'schema', 'table1', 'TABLE']];
            $outer->{dbd_nullp_data} = [['catalog', 'schema', 'table2', 'TABLE']];
            $outer->{dbd_nullp_data} = [['catalog', 'schema', 'table3', 'TABLE']];
        }
        $outer->STORE(NUM_OF_FIELDS => 5);
        $sth->STORE(Active => 1);
        return $outer;
    }

    sub prepare {
	my ($dbh, $statement)= @_;

	my ($outer, $sth) = DBI::_new_sth($dbh, {
	    'Statement'     => $statement,
        });

	return $outer;
    }

    sub FETCH {
	my ($dbh, $attrib) = @_;
	# In reality this would interrogate the database engine to
	# either return dynamic values that cannot be precomputed
	# or fetch and cache attribute values too expensive to prefetch.
	return $dbh->SUPER::FETCH($attrib);
    }

    sub STORE {
	my ($dbh, $attrib, $value) = @_;
	# would normally validate and only store known attributes
	# else pass up to DBI to handle
	if ($attrib eq 'AutoCommit') {
	    Carp::croak("Can't disable AutoCommit") unless $value;
            # convert AutoCommit values to magic ones to let DBI
            # know that the driver has 'handled' the AutoCommit attribute
            $value = ($value) ? -901 : -900;
	} elsif ($attrib eq 'nullp_set_err') {
           # a fake attribute to produce a test case where STORE issues a warning
           $dbh->set_err($value, $value);
        }
	return $dbh->SUPER::STORE($attrib, $value);
    }

    sub ping { 1 }

    sub disconnect {
	shift->STORE(Active => 0);
    }

}


{   package DBD::NullP::st; # ====== STATEMENT ======
    our $imp_data_size = 0;
    use strict;

    sub bind_param {
        my ($sth, $param, $value, $attr) = @_;
        $sth->{ParamValues}{$param} = $value;
        $sth->{ParamAttr}{$param}   = $attr
            if defined $attr; # attr is sticky if not explicitly set
        return 1;
    }

    sub execute {
	my $sth = shift;
        $sth->bind_param($_, $_[$_-1]) for (1..@_);
        if ($sth->{Statement} =~ m/^ \s* SELECT \s+/xmsi) {
            $sth->STORE(NUM_OF_FIELDS => 1);
            $sth->{NAME} = [ "fieldname" ];
            # just for the sake of returning something, we return the params
            my $params = $sth->{ParamValues} || {};
            $sth->{dbd_nullp_data} = [ @{$params}{ sort keys %$params } ];
            $sth->STORE(Active => 1);
        }
        # force a sleep - handy for testing
        elsif ($sth->{Statement} =~ m/^ \s* SLEEP \s+ (\S+) /xmsi) {
            my $secs = $1;
            if (eval { require Time::HiRes; defined &Time::HiRes::sleep }) {
                Time::HiRes::sleep($secs);
            }
            else {
                sleep $secs;
            }
        }
        # force an error - handy for testing
        elsif ($sth->{Statement} =~ m/^ \s* ERROR \s+ (\d+) \s* (.*) /xmsi) {
            return $sth->set_err($1, $2);
        }
        # anything else is silently ignored, successfully
	1;
    }

    sub fetchrow_arrayref {
	my $sth = shift;
	my $data = shift @{$sth->{dbd_nullp_data}};
        if (!$data || !@$data) {
            $sth->finish;     # no more data so finish
            return undef;
	}
        return $sth->_set_fbav($data);
    }
    *fetch = \&fetchrow_arrayref; # alias

    sub FETCH {
	my ($sth, $attrib) = @_;
	# would normally validate and only fetch known attributes
	# else pass up to DBI to handle
	return $sth->SUPER::FETCH($attrib);
    }

    sub STORE {
	my ($sth, $attrib, $value) = @_;
	# would normally validate and only store known attributes
	# else pass up to DBI to handle
	return $sth->SUPER::STORE($attrib, $value);
    }

}

1;
