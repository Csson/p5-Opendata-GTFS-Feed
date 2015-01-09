use 5.10.1;
use strict;
use warnings;

use Opendata::GTFS::Feed::Parser;

package Opendata::GTFS::Feed;

# VERSION
# ABSTRACT: Parse General Transit Feeds (GTFS)

sub parse {
	shift;
	return Opendata::GTFS::Feed::Parser->new(@_);
}

1;

__END__

=pod

=head1 SYNOPSIS

    use Opendata::GTFS::Feed;
    my $feed = Opendata::GTFS::Feed->parse(file => 'a-gtfs-feed.zip', directory => 'feed');

=head1 DESCRIPTION

Opendata::GTFS::Feed is ...

=head1 SEE ALSO

=cut
