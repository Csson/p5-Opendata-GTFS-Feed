use Opendata::GTFS::Standard;
use strict;
use warnings;

# PODCLASSNAME
# ABSTRACT: Fare rule

class Opendata::GTFS::Type::FareRule using Moose {

    # VERSION

    my @columns = qw/
        1 fare_id
        0 route_id
        0 origin_id
        0 destination_id
        0 contains_id
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

:splint classname Opendata::GTFS::Type::FareRule

=head1 ATTRIBUTES

:splint attributes

=cut
