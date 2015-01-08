use 5.14.0;

# VERSION

package Opendata::GTFS::Standard::Moops {

    use base 'Moops';
    use List::AllUtils();
    use Types::Opendata::GTFS();
    

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'List::AllUtils'    => [qw/any none sum uniq zip/],
            'Types::Opendata::GTFS' => [{ replace => 1 }, '-types'],
        );

        $class->SUPER::import(%opts);
    }
}

1;
