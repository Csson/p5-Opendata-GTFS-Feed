use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::Transfer;

# ABSTRACT: Transfer
# AUTHORITY
our $VERSION = '0.0203';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    1 from_stop_id
    1 to_stop_id
    1 transfer_type
    0 min_transfer_time
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

:splint classname Opendata::GTFS::Type::Transfer

=head1 ATTRIBUTES

:splint attributes

=cut
