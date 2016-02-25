use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::StopTime;

# ABSTRACT: Stop time
# AUTHORITY
our $VERSION = '0.0202';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    1 trip_id
    1 arrival_time
    1 departure_time
    1 stop_id
    1 stop_sequence
    0 stop_headsign
    0 pickup_type
    0 drop_off_type
    0 shape_dist_traveled
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

:splint classname Opendata::GTFS::Type::StopTime

=head1 ATTRIBUTES

:splint attributes

=cut
