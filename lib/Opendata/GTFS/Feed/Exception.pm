use 5.14.0;
use warnings;

# VERSION:

# Insired by Throwable::X
package Opendata::GTFS::Feed::Exception {

    use Moose::Role;
    use Throwable::X::Types;

    use namespace::clean -except => 'meta';

    use Sub::Exporter -setup => {
        exports => { Payload => \'__payload' },
    };

    sub __payload {
        sub {
            'Role::HasPayload::Meta::Attribute::Payload';
        }
    }

    sub out {
        my $self = shift;
        say $self->message;
        say '';
        say $self->stack_trace;
        return $self;
    }
    sub fatal {
        die;
    }
    with(
        'Throwable',
        'StackTrace::Auto',
        'Role::HasPayload::Merged',
        'Role::HasMessage::Errf' => {
            default => sub { $_[0]->info },
            lazy => 1,
        }
    );
}

1;
