use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Feed::Parser
# ABSTRACT:

class Opendata::GTFS::Feed::Parser using Moose {

	has file => (
	    is => 'ro',
	    isa => AbsPath,
	    coerce => 1,
	);
	
	method BUILD {
		say 'hej';
	}

}
