use strict;
use warnings FATAL => 'all';
use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Opendata::GTFS::Feed;

# replace with the actual test
ok 1;

my $feed = Opendata::GTFS::Feed->parse(file => '~/Downloads/sweden-gtfs.zip');



done_testing;
