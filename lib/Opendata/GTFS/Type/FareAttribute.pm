use Opendata::GTFS::Standard;
use strict;
use warnings;

# PODCLASSNAME
# ABSTRACT: Fare attribute

class Opendata::GTFS::Type::FareAttribute using Moose {

    # VERSION

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
}

1;

=pod

=encoding utf-8

:splint classname Opendata::GTFS::Type::FareAttribute

=head1 ATTRIBUTES

:splint attributes

=cut
