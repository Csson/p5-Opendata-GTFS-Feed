use Map::Metro::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Feed::Exception::FeedContainsFaultyHeader

class Opendata::GTFS::Feed::Exception::FeedContainsFaultyHeader with Opendata::GTFS::Feed::Exception using Moose {

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
