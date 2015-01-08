use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Type::FareAttribute
# ABSTRACT:

class Opendata::GTFS::Type::FareAttribute using Moose {

    my @columns = qw/
        1 fare_id
        1 price
        1 currency_type
        1 payment_method
        1 transfers
        0 transfer_duration
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
