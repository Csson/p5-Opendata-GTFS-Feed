use strict;
use warnings FATAL => 'all';
use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Opendata::GTFS::Feed;

# replace with the actual test
ok 1;

my $feed = Opendata::GTFS::Feed->parse(file => 't/corpus/gtfs/sample-feed.zip');

is $feed->agency_count, 1, 'Correct number of agencies';

is $feed->calendar_count, 2, 'Correct number of calendars';

is $feed->calendar_date_count, 1, 'Correct number of calendar dates';

is $feed->fare_attribute_count, 2, 'Correct number of fare attributes';

is $feed->route_count, 5, 'Correct number of routes';

is $feed->stop_count, 9, 'Correct number of stops';

is $feed->stop_time_count, 28, 'Correct number of stop times';

is $feed->trip_count, 11, 'Correct number of trips';

done_testing;
