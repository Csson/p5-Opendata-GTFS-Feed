use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Type::Trip
# ABSTRACT:

class Opendata::GTFS::Type::Trip using Moose {

    my @columns = qw/
        1 route_id
        1 service_id
        1 trip_id
        0 trip_headsign
        0 trip_short_name
        0 direction_id
        0 block_id
        0 shape_id
        0 wheelchair_accessible
        0 bikes_allowed
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
