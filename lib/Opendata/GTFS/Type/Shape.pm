use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::Shape;

# ABSTRACT: Shape:
# AUTHORITY
our $VERSION = '0.0201';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    1 shape_id
    1 shape_pt_lat
    1 shape_pt_lon
    1 shape_pt_sequence
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

:splint classname Opendata::GTFS::Type::Shape

=head1 ATTRIBUTES

:splint attributes

=cut
