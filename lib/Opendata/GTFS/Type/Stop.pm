use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::Stop;

# ABSTRACT: Stop
# AUTHORITY
our $VERSION = '0.0203';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    1 stop_id
    0 stop_code
    1 stop_name
    0 stop_desc
    1 stop_lat
    1 stop_lon
    0 zone_id
    0 stop_url
    0 location_type
    0 parent_station
    0 stop_timezone
    0 wheelchair_boarding
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

:splint classname Opendata::GTFS::Type::Stop

=head1 ATTRIBUTES

:splint attributes

=cut
