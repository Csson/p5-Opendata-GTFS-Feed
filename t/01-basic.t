use strict;
use warnings FATAL => 'all';
use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Opendata::GTFS::Feed;

# replace with the actual test
ok 1;

my $feed = Opendata::GTFS::Feed->parse(directory => '~/Downloads/northern-indiana-gtfs');

is $feed->agency_count, 1, 'Correct number of agencies';

is $feed->calendar_count, 2, 'Correct number of calendars';

is $feed->route_count, 1, 'Correct number of routes';

is $feed->stop_count, 19, 'Correct number of stops';

is $feed->stoptime_count, 802, 'Correct number of stoptimes';

is $feed->trip_count, 62, 'Correct number of trips';


done_testing;
