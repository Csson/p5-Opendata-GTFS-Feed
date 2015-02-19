use Opendata::GTFS::Standard;
use strict;
use warnings;

# PODCLASSNAME
# ABSTRACT: Calendar

class Opendata::GTFS::Type::Calendar using Moose {

    # VERSION

    my @columns = qw/
        1 service_id
        1 monday
        1 tuesday
        1 wednesday
        1 thursday
        1 friday
        1 saturday
        1 sunday
        1 start_date
        1 end_date
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

:splint classname Opendata::GTFS::Type::Calendar

=head1 ATTRIBUTES

:splint attributes

=cut
