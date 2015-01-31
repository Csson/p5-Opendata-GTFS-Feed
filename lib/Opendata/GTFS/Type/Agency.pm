use Opendata::GTFS::Standard;

# VERSION:
# PODCLASSNAME
# ABSTRACT: Agency

class Opendata::GTFS::Type::Agency using Moose {

    my @columns = qw/
        0 agency_id
        1 agency_name
        1 agency_url
        1 agency_timezone
        0 agency_lang
        0 agency_phone
        0 agency_fare_url
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
