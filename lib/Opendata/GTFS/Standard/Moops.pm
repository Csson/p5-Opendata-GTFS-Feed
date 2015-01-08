use 5.14.0;

# VERSION

package Opendata::GTFS::Standard::Moops {

    use base 'Moops';
    use List::AllUtils();
    use Map::Metro::Types();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'List::AllUtils'    => [qw/any none sum uniq/],
            'Opendata::GTFS::Types' => [{ replace => 1 }, '-types'],
        );

        $class->SUPER::import(%opts);
    }
}

1;
