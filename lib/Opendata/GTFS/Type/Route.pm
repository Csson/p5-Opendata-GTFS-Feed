use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::Route;

# ABSTRACT: Route
# AUTHORITY
our $VERSION = '0.0105';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    1 route_id
    0 agency_id
    0 route_short_name
    0 route_long_name
    0 route_desc
    1 route_type
    0 route_url
    0 route_color
    0 route_text_color
/;

for (my $i = 0; $i < $#columns; $i += 2) {
    my $required = $columns[$i];
    my $column = $columns[$i + 1];

    has $column => (
        is => 'ro',
        isa => ($required ? Str : Maybe[Str]),
    );
}

__PACKAGE__->meta->make_immutable;

1;

=pod

=encoding utf-8

:splint classname Opendata::GTFS::Type::Route

=head1 ATTRIBUTES

:splint attributes

=cut
