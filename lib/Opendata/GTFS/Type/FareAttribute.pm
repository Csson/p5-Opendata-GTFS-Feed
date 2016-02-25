use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Type::FareAttribute;

# ABSTRACT: Fare attribute
# AUTHORITY
our $VERSION = '0.0202';

use Opendata::GTFS::Feed::Elk;
use Types::Standard qw/Maybe Str/;

my @columns = qw/
    1 fare_id
    1 price
    1 currency_type
    1 payment_method
    1 transfers
    0 transfer_duration
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

:splint classname Opendata::GTFS::Type::FareAttribute

=head1 ATTRIBUTES

:splint attributes

=cut
