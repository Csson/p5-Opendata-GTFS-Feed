use Opendata::GTFS::Standard;
use strict;
use warnings;

# PODCLASSNAME
# ABSTRACT: Shape:

class Opendata::GTFS::Type::Shape using Moose {

    # VERSION

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
}

1;

=pod

=encoding utf-8

:splint classname Opendata::GTFS::Type::Shape

=head1 ATTRIBUTES

:splint attributes

=cut
