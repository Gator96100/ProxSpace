
###
# XML::SAX::Expat - SAX2 Driver for Expat (XML::Parser)
# Originally by Robin Berjon
###

package XML::SAX::Expat;
use strict;
use base qw(XML::SAX::Base);
use XML::NamespaceSupport   qw();
use XML::Parser             qw();

use vars qw($VERSION);
$VERSION = '0.51';


#,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#
#`,`, Variations on parse `,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,#
#```````````````````````````````````````````````````````````````````#

#-------------------------------------------------------------------#
# CharacterStream
#-------------------------------------------------------------------#
sub _parse_characterstream {
    my $p       = shift;
    my $xml     = shift;
    my $opt     = shift;

    my $expat = $p->_create_parser($opt);
    my $result = $expat->parse($xml);
    $p->_cleanup;
    return $result;
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# ByteStream
#-------------------------------------------------------------------#
sub _parse_bytestream {
    my $p       = shift;
    my $xml     = shift;
    my $opt     = shift;

    my $expat = $p->_create_parser($opt);
    my $result = $expat->parse($xml);
    $p->_cleanup;
    return $result;
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# String
#-------------------------------------------------------------------#
sub _parse_string {
    my $p       = shift;
    my $xml     = shift;
    my $opt     = shift;

    my $expat = $p->_create_parser($opt);
    my $result = $expat->parse($xml);
    $p->_cleanup;
    return $result;
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# SystemId
#-------------------------------------------------------------------#
sub _parse_systemid {
    my $p       = shift;
    my $xml     = shift;
    my $opt     = shift;

    my $expat = $p->_create_parser($opt);
    my $result = $expat->parsefile($xml);
    $p->_cleanup;
    return $result;
}
#-------------------------------------------------------------------#


#-------------------------------------------------------------------#
# $p->_create_parser(\%options)
#-------------------------------------------------------------------#
sub _create_parser {
    my $self = shift;
    my $opt  = shift;

    die "ParserReference: parser instance ($self) already parsing\n"
         if $self->{_InParse};

    my $featUri = 'http://xml.org/sax/features/';
    my $ppe = ($self->get_feature($featUri . 'external-general-entities') or
               $self->get_feature($featUri . 'external-parameter-entities') ) ? 1 : 0;

    my $expat = XML::Parser->new( ParseParamEnt => $ppe );
    $expat->{__XSE} = $self;
    $expat->setHandlers(
                        Init        => \&_handle_init,
                        Final       => \&_handle_final,
                        Start       => \&_handle_start,
                        End         => \&_handle_end,
                        Char        => \&_handle_char,
                        Comment     => \&_handle_comment,
                        Proc        => \&_handle_proc,
                        CdataStart  => \&_handle_start_cdata,
                        CdataEnd    => \&_handle_end_cdata,
                        Unparsed    => \&_handle_unparsed_entity,
                        Notation    => \&_handle_notation_decl,
                        #ExternEnt
                        #ExternEntFin
                        Entity      => \&_handle_entity_decl,
                        Element     => \&_handle_element_decl,
                        Attlist     => \&_handle_attr_decl,
                        Doctype     => \&_handle_start_doctype,
                        DoctypeFin  => \&_handle_end_doctype,
                        XMLDecl     => \&_handle_xml_decl,
                      );

    $self->{_InParse} = 1;
    $self->{_NodeStack} = [];
    $self->{_NSStack} = [];
    $self->{_NSHelper} = XML::NamespaceSupport->new({xmlns => 1});
    $self->{_started} = 0;

    return $expat;
}
#-------------------------------------------------------------------#


#-------------------------------------------------------------------#
# $p->_cleanup
#-------------------------------------------------------------------#
sub _cleanup {
    my $self = shift;

    $self->{_InParse} = 0;
    delete $self->{_NodeStack};
}
#-------------------------------------------------------------------#



#,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#
#`,`, Expat Handlers ,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,#
#```````````````````````````````````````````````````````````````````#

#-------------------------------------------------------------------#
# _handle_init
#-------------------------------------------------------------------#
sub _handle_init {
    #my $self    = shift()->{__XSE};

    #my $document = {};
    #push @{$self->{_NodeStack}}, $document;
    #$self->SUPER::start_document($document);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_final
#-------------------------------------------------------------------#
sub _handle_final {
    my $self    = shift()->{__XSE};

    #my $document = pop @{$self->{_NodeStack}};
    return $self->SUPER::end_document({});
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_start
#-------------------------------------------------------------------#
sub _handle_start {
    my $self    = shift()->{__XSE};
    my $e_name  = shift;
    my %attr    = @_;

    # start_document data
    $self->_handle_start_document({}) unless $self->{_started};

    # take care of namespaces
    my $nsh = $self->{_NSHelper};
    $nsh->push_context;
    my @new_ns;
    for my $k (grep !index($_, 'xmlns'), keys %attr) {
        $k =~ m/^xmlns(:(.*))?$/;
        my $prefix = $2 || '';
        $nsh->declare_prefix($prefix, $attr{$k});
        my $ns = {
                    Prefix       => $prefix,
                    NamespaceURI => $attr{$k},
                 };
        push @new_ns, $ns;
        $self->SUPER::start_prefix_mapping($ns);
    }
    push @{$self->{_NSStack}}, \@new_ns;


    # create the attributes
    my %saxattr;
    map {
        my ($ns,$prefix,$lname) = $nsh->process_attribute_name($_);
        $saxattr{'{' . ($ns || '') . '}' . $lname} = {
                                    Name         => $_,
                                    LocalName    => $lname || '',
                                    Prefix       => $prefix || '',
                                    Value        => $attr{$_},
                                    NamespaceURI => $ns || '',
                                 };
    } keys %attr;


    # now the element
    my ($ns,$prefix,$lname) = $nsh->process_element_name($e_name);
    my $element = {
                    Name         => $e_name,
                    LocalName    => $lname || '',
                    Prefix       => $prefix || '',
                    NamespaceURI => $ns || '',
                    Attributes   => \%saxattr,
                   };

    push @{$self->{_NodeStack}}, $element;
    $self->SUPER::start_element($element);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_end
#-------------------------------------------------------------------#
sub _handle_end {
    my $self    = shift()->{__XSE};

    my %element = %{pop @{$self->{_NodeStack}}};
    delete $element{Attributes};
    $self->SUPER::end_element(\%element);

    my $prev_ns = pop @{$self->{_NSStack}};
    for my $ns (@$prev_ns) {
        $self->SUPER::end_prefix_mapping( { %$ns } );
    }
    $self->{_NSHelper}->pop_context;
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_char
#-------------------------------------------------------------------#
sub _handle_char {
    $_[0]->{__XSE}->_handle_start_document({}) unless $_[0]->{__XSE}->{_started};
    $_[0]->{__XSE}->SUPER::characters({ Data => $_[1] });
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_comment
#-------------------------------------------------------------------#
sub _handle_comment {
    $_[0]->{__XSE}->_handle_start_document({}) unless $_[0]->{__XSE}->{_started};
    $_[0]->{__XSE}->SUPER::comment({ Data => $_[1] });
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_proc
#-------------------------------------------------------------------#
sub _handle_proc {
    $_[0]->{__XSE}->_handle_start_document({}) unless $_[0]->{__XSE}->{_started};
    $_[0]->{__XSE}->SUPER::processing_instruction({ Target => $_[1], Data => $_[2] });
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_start_cdata
#-------------------------------------------------------------------#
sub _handle_start_cdata {
    $_[0]->{__XSE}->SUPER::start_cdata( {} );
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_end_cdata
#-------------------------------------------------------------------#
sub _handle_end_cdata {
    $_[0]->{__XSE}->SUPER::end_cdata( {} );
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_xml_decl
#-------------------------------------------------------------------#
sub _handle_xml_decl {
    my $self    = shift()->{__XSE};
    my $version     = shift;
    my $encoding    = shift;
    my $standalone  = shift;

    if (not defined $standalone) { $standalone = '';    }
    elsif ($standalone)          { $standalone = 'yes'; }
    else                         { $standalone = 'no';  }
    my $xd = {
                Version     => $version,
                Encoding    => $encoding,
                Standalone  => $standalone,
             };
    #$self->SUPER::xml_decl($xd);
    $self->_handle_start_document($xd);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_notation_decl
#-------------------------------------------------------------------#
sub _handle_notation_decl {
    my $self    = shift()->{__XSE};
    my $notation    = shift;
    shift;
    my $system      = shift;
    my $public      = shift;

    my $not = {
                Name        => $notation,
                PublicId    => $public,
                SystemId    => $system,
              };
    $self->SUPER::notation_decl($not);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_unparsed_entity
#-------------------------------------------------------------------#
sub _handle_unparsed_entity {
    my $self    = shift()->{__XSE};
    my $name        = shift;
    my $system      = shift;
    my $public      = shift;
    my $notation    = shift;

    my $ue = {
                Name        => $name,
                PublicId    => $public,
                SystemId    => $system,
                Notation    => $notation,
             };
    $self->SUPER::unparsed_entity_decl($ue);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_element_decl
#-------------------------------------------------------------------#
sub _handle_element_decl {
    $_[0]->{__XSE}->SUPER::element_decl({ Name => $_[1], Model => "$_[2]" });
}
#-------------------------------------------------------------------#


#-------------------------------------------------------------------#
# _handle_attr_decl
#-------------------------------------------------------------------#
sub _handle_attr_decl {
    my $self    = shift()->{__XSE};
    my $ename   = shift;
    my $aname   = shift;
    my $type    = shift;
    my $default = shift;
    my $fixed   = shift;

    my ($vd, $value);
    if ($fixed) {
        $vd = '#FIXED';
        $default =~ s/^(?:"|')//; #"
        $default =~ s/(?:"|')$//; #"
        $value = $default;
    }
    else {
        if ($default =~ m/^#/) {
            $vd = $default;
            $value = '';
        }
        else {
            $vd = ''; # maybe there's a default ?
            $default =~ s/^(?:"|')//; #"
            $default =~ s/(?:"|')$//; #"
            $value = $default;
        }
    }

    my $at = {
                eName           => $ename,
                aName           => $aname,
                Type            => $type,
                ValueDefault    => $vd,
                Value           => $value,
             };
    $self->SUPER::attribute_decl($at);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_entity_decl
#-------------------------------------------------------------------#
sub _handle_entity_decl {
    my $self    = shift()->{__XSE};
    my $name    = shift;
    my $val     = shift;
    my $sys     = shift;
    my $pub     = shift;
    my $ndata   = shift;
    my $isprm   = shift;

    # deal with param ents
    if ($isprm) {
        $name = '%' . $name;
    }

    # int vs ext
    if ($val) {
        my $ent = {
                    Name    => $name,
                    Value   => $val,
                  };
        $self->SUPER::internal_entity_decl($ent);
    }
    else {
        my $ent = {
                    Name        => $name,
                    PublicId    => $pub || '',
                    SystemId    => $sys,
                  };
        $self->SUPER::external_entity_decl($ent);
    }
}
#-------------------------------------------------------------------#


#-------------------------------------------------------------------#
# _handle_start_doctype
#-------------------------------------------------------------------#
sub _handle_start_doctype {
    my $self    = shift()->{__XSE};
    my $name    = shift;
    my $sys     = shift;
    my $pub     = shift;

    $self->_handle_start_document({}) unless $self->{_started};

    my $dtd = {
                Name        => $name,
                SystemId    => $sys,
                PublicId    => $pub,
              };
    $self->SUPER::start_dtd($dtd);
}
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
# _handle_end_doctype
#-------------------------------------------------------------------#
sub _handle_end_doctype {
    $_[0]->{__XSE}->SUPER::end_dtd( {} );
}
#-------------------------------------------------------------------#


#-------------------------------------------------------------------#
# _handle_start_document
#-------------------------------------------------------------------#
sub _handle_start_document {
    $_[0]->SUPER::start_document($_[1]);
    $_[0]->{_started} = 1;
}
#-------------------------------------------------------------------#


#-------------------------------------------------------------------#
# supported_features
#-------------------------------------------------------------------#
sub supported_features {
    return (
             $_[0]->SUPER::supported_features,
             'http://xml.org/sax/features/external-general-entities',
             'http://xml.org/sax/features/external-parameter-entities',
           );
}
#-------------------------------------------------------------------#





#,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#
#`,`, Private Helpers `,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,#
#```````````````````````````````````````````````````````````````````#

#-------------------------------------------------------------------#
# _create_node
#-------------------------------------------------------------------#
#sub _create_node {
#    shift;
#    # this may check for a factory later
#    return {@_};
#}
#-------------------------------------------------------------------#


1;
#,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#
#`,`, Documentation `,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,`,#
#```````````````````````````````````````````````````````````````````#

=pod

=head1 NAME

XML::SAX::Expat - SAX2 Driver for Expat (XML::Parser)

=head1 SYNOPSIS

  use XML::SAX::Expat;
  use XML::SAX::MyFooHandler;
  my $h = XML::SAX::MyFooHandler->new;
  my $p = XML::SAX::Expat->new(Handler => $h);
  $p->parse_file('/path/to/foo.xml');

=head1 DESCRIPTION

This is an implementation of a SAX2 driver sitting on top of Expat
(XML::Parser) which Ken MacLeod posted to perl-xml and which I have
updated.

It is still incomplete, though most of the basic SAX2 events should be
available. The SAX2 spec is currently available from L<http://perl-xml.sourceforge.net/perl-sax/>.

A more friendly URL as well as a PODification of the spec are in the
works.

=head1 METHODS

The methods defined in this class correspond to those listed in the
PerlSAX2 specification, available above.

=head1 FEATURES AND CAVEATS

=over 2

=item supported_features

Returns:

  * http://xml.org/sax/features/external-general-entities
  * http://xml.org/sax/features/external-parameter-entities
  * [ Features supported by ancestors ]

Turning one of the first two on also turns the other on (this maps
to the XML::Parser ParseParamEnts option). This may be fixed in the
future, so don't rely on this behaviour.

=back

=head1 MISSING PARTS

XML::Parser has no listed callbacks for the following events, which
are therefore not presently generated (ways may be found in the
future):

  * ignorable_whitespace
  * skipped_entity
  * start_entity / end_entity
  * resolve_entity

Ways of signalling them are welcome. In addition to those,
set_document_locator is not yet called.

=head1 TODO

  - reuse Ken's tests and add more

=head1 AUTHOR

Robin Berjon; stolen from Ken Macleod, ken@bitsko.slc.ut.us, and with
suggestions and feedback from perl-xml. Currently maintained by Bjoern
Hoehrmann, L<http://bjoern.hoehrmann.de/>.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2001-2008 Robin Berjon. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself.

=head1 SEE ALSO

XML::Parser::PerlSAX

=cut
