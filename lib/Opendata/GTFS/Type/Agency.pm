use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::Agency;

# ABSTRACT: Agency
# AUTHORITY
our $VERSION = '0.0203';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    0 agency_id
    1 agency_name
    1 agency_url
    1 agency_timezone
    0 agency_lang
    0 agency_phone
    0 agency_fare_url
/;

for (my $i = 0; $i < $#columns; $i += 2) {
    my $required = $columns[$i];
    my $column = $columns[$i + 1];

    has $column => (
        is => 'ro',
        isa => ($required ? Str : Maybe[Str]),
    );
}

__PACKAGE__->meta->make_immutable;

1;

=pod

=encoding utf-8

:splint classname Opendata::GTFS::Type::Agency

=head1 ATTRIBUTES

:splint attributes

=cut
