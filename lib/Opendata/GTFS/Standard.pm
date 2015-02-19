use 5.14.0;

# VERSION

package Opendata::GTFS::Standard {

    use base 'Moops';
    use List::AllUtils();
    use MooseX::StrictConstructor();
    use Types::Opendata::GTFS();
    use Safe::Isa;

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'List::AllUtils'    => [qw/any none sum uniq zip first_index/],
            'Types::Opendata::GTFS' => [{ replace => 1 }, '-types'],
            'MooseX::StrictConstructor' => [],
            'Safe::Isa' => ['$_does'],
        );

        $class->SUPER::import(%opts);
    }
}

1;
