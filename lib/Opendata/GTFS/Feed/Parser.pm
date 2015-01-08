use Opendata::GTFS::Standard::Moops;

# VERSION
# PODNAME: Opendata::GTFS::Feed::Parser
# ABSTRACT:

use Archive::Extract;
use File::Temp;
use Text::CSV;
use Lingua::EN::Inflect;

use Opendata::GTFS::Feed::Parser::Agency;
use Opendata::GTFS::Feed::Parser::Route;
use Opendata::GTFS::Feed::Parser::Stop;
use Opendata::GTFS::Feed::Parser::Trip;

class Opendata::GTFS::Feed::Parser using Moose {

    use Path::Tiny;

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

    my @attributes = (
        Agency,
        Route,
        Stop,
        Trip,
    );

    foreach my $type (@attributes) {
        my $attribute = Lingua::EN::Inflect::PL(lc $type->name);
        my $singular = lc $type->name;

        has $attribute => (
            is => 'rw',
            isa => ArrayRef[ $type ],
            traits => ['Array'],
            default => sub { [] },
            handles => {
                "add_$singular" => 'push',
                "all_$attribute" => 'elements',
            }
        );
    }

    around BUILDARGS($orig: $self, @args) {
        my %args = @args;
        if(!exists $args{'directory'}) {
            $args{'directory'} = File::Temp->newdir;
        }
        $args{'directory'} = path($args{'directory'})->absolute;
        if(exists $args{'file'}) {
            if(path($args{'file'})->exists) {
                $args{'file'} = path($args{'file'})->absolute;
                my $x = Archive::Extract->new(archive => $args{'file'}->stringify);
                $x->extract(to => $args{'directory'}->stringify) or die $x->error;
            }
            else {
                die sprintf 'Supplied filepath (%s) does not exist.', $args{'file'};
            }
        }
        $self->$orig(%args);
    }

    method BUILD {
        $self->parse_file(Agency, 'agency.txt');
        $self->parse_file(Route, 'routes.txt');
        $self->parse_file(Stop, 'stops.txt');
        $self->parse_file(Trip, 'trip.txt');

        warn join "\n" => map { $_->trip_id } $self->all_trips;
    }

    method parse_file($type, $filename) {
        my $method = sprintf 'add_%s', lc $type->name;
        my $class = sprintf 'Opendata::GTFS::Feed::Parser::%s', $type->name;

        my $csv = Text::CSV->new( { binary => 1} );
        open my $fh, '<:encoding(utf8)', $self->directory->child($filename) or die sprintf "Can't open %s", $self->directory->child($filename);
        $csv->column_names($csv->getline($fh));

        LINE:
        while(1) {
            my $line = $csv->getline_hr($fh);
            last LINE if $csv->eof;

            $self->$method($class->new(%{ $line} ));
        }

        close $fh or die sprintf "Can't close %s", $self->directory->child($filename);
    }
}
