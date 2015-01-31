use Opendata::GTFS::Standard;

# VERSION
# PODCLASSNAME
# ABSTRACT: Fare rule

class Opendata::GTFS::Type::FareRule using Moose {

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
