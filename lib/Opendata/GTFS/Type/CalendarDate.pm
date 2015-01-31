use Opendata::GTFS::Standard;

# VERSION
# PODCLASSNAME
# ABSTRACT: Calendar date

class Opendata::GTFS::Type::CalendarDate using Moose {

    my @columns = qw/
        1 service_id
        1 date
        1 exception_type
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
