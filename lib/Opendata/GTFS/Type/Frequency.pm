use Opendata::GTFS::Standard;

# VERSION
# PODCLASSNAME
# ABSTRACT: Frequency

class Opendata::GTFS::Type::Frequency using Moose {

    my @columns = qw/
        1 trip_id
        1 start_time
        1 end_time
        1 headway_secs
        0 exact_times
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
