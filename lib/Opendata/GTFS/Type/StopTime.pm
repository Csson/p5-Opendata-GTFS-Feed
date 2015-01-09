use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Type::StopTime
# ABSTRACT:

class Opendata::GTFS::Type::StopTime using Moose {

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
}
