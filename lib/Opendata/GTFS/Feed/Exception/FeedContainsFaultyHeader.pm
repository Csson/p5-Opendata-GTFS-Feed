use Opendata::GTFS::Standard;
use strict;
use warnings;

# PODCLASSNAME

class Opendata::GTFS::Feed::Exception::FeedContainsFaultyHeader with Opendata::GTFS::Feed::Exception using Moose {

    # VERSION:
    use Opendata::GTFS::Feed::Exception -all;

    has filename => (
        is => 'ro',
        isa => Any,
        traits => [Payload],
    );
    has header => (
        is => 'ro',
        isa => Any,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Feed contains faulty header [%{header}s] in file [%{filename}s]},
    );
}

1;
