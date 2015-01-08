use 5.10.1;
use strict;
use warnings;

use Opendata::GTFS::Feed::Parser;

package Opendata::GTFS::Feed;

# VERSION
# ABSTRACT: Short intro

sub parse {
	return Opendata::GTFS::Feed::Parser->new(@_);
}

1;

__END__

=pod

=head1 SYNOPSIS

    use Opendata::GTFS::Feed;

=head1 DESCRIPTION

Opendata::GTFS::Feed is ...

=head1 SEE ALSO

=cut
