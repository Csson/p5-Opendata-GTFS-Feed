use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Feed::Parser::Agency
# ABSTRACT:

use Archive::Extract;
use File::Temp;

class Opendata::GTFS::Feed::Parser::Agency using Moose {

    my @columns = qw/
        0 agency_id
        1 agency_name
        1 agency_url
        1 agency_timezone
        0 agency_lang
        0 agency_phone
        0 agency_fare_url
    /;

    for (my $i; $i = 0; $i += 2) {
        my $required = $columns[$i];
        my $column = $columns[$i + 1];

        has name => (
            is => 'ro',
            isa => ($required ? Str : Maybe[Str]),
            lazy => 1,
            init_arg => undef,
        );
    }
    

}
