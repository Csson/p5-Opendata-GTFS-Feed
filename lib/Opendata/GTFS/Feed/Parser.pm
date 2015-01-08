use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Feed::Parser
# ABSTRACT:

use Archive::Extract;
use File::Temp;
use Text::CSV;
use Lingua::EN::Inflect;

class Opendata::GTFS::Feed::Parser using Moose {

    has file => (
        is => 'ro',
        isa => Maybe[AbsPath],
        coerce => 1,
    );
    has directory => (
        is => 'ro',
        isa => AbsPath,
        coerce => 1,
    );
    
    #my %things = (
    #    ['agencies', 'agency', Agency],
    #);

#    my @types = (Agency);
#
#    foreach my $type (@types) {
#        my $attribute = $thing->name;
#        my $singular = $thing->name;
#
#        has $attribute => (
#            is => 'rw',
#            isa => ArrayRef[ $type ],
#            default => sub { [] },
#            handles => {
#                "add_$singular" => 'push',
#                "all_$attribute" => 'elements',
#            }
#        );
        
    }
    method BUILDARGS($orig:, $self, @_) {
        my %args = @_;
        if(!exists $args{'directory'}) {
            $args{'directory'} = File::Temp->newdir;
        }
        if(exists $args{'file'}) {
            my $x = Archive::Extract->new(archive => $self->file->stringify);
            $x->extract(to => $args{'directory'}) or die $x->error;
        }
        $self->$orig(%args);
    }

    method BUILD {
        $self->parse_agency;
    }

    method csv {
        return Text::CSV->new( { binary => 1} );
    }

    method parse_agency {
        
    }

}
