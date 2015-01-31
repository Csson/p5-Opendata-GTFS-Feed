use Opendata::GTFS::Standard;

# VERSION
# PODCLASSNAME
# ABSTRACT: Transfer

class Opendata::GTFS::Type::Transfer using Moose {

    my @columns = qw/
        1 from_stop_id
        1 to_stop_id
        1 transfer_type
        0 min_transfer_time
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
