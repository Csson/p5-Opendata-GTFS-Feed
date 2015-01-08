use Opendata::GTFS::Standard::Moops;    

# VERSION
# PODNAME: Opendata::GTFS::Feed::Parser
# ABSTRACT:

use Archive::Extract;
use File::Temp;
use Text::CSV;
use Lingua::EN::Inflect;

use File::BOM;

use Opendata::GTFS::Type::Agency;
use Opendata::GTFS::Type::Calendar;
use Opendata::GTFS::Type::CalendarDate;
use Opendata::GTFS::Type::FareAttribute;
use Opendata::GTFS::Type::FareRule;
use Opendata::GTFS::Type::Frequency;
use Opendata::GTFS::Type::Route;
use Opendata::GTFS::Type::Shape;
use Opendata::GTFS::Type::Stop;
use Opendata::GTFS::Type::StopTime;
use Opendata::GTFS::Type::Transfer;
use Opendata::GTFS::Type::Trip;

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
        Agency,        1 => 'agency.txt',
        Stop,          1 => 'stops.txt',
        Route,         1 => 'routes.txt',
        Trip,          1 => 'trips.txt',
        StopTime,      1 => 'stop_times.txt',
        Calendar,      1 => 'calendar.txt',
        CalendarDate,  0 => 'calendar_dates.txt',
        FareAttribute, 0 => 'fare_attributes.txt',
        FareRule,      0 => 'fare_rules.txt',
        Shape,         0 => 'shapes.txt',
        Frequency,     0 => 'frequencies.txt',
        Transfer,      0 => 'transfers.txt',
    );

    fun type_to_singular($type) {
        my $name = $type->name;
        $name =~ s{(?<=[a-z])([A-Z])}{_$1}g;
        return lc $name;
    }
    fun type_to_plural($type) {
        my @names = split /_/ => type_to_singular($type);
        $names[-1] = Lingua::EN::Inflect::PL($names[-1]);
        return join '_' => @names;
    }

    for (my $i = 0; $i < $#attributes; $i += 3) {
        my $type = $attributes[$i];
        my $attribute = type_to_plural($type);
        my $singular = type_to_singular($type);

        has $attribute => (
            is => 'rw',
            isa => ArrayRef[ $type ],
            traits => ['Array'],
            default => sub { [] },
            handles => {
                "add_$singular" => 'push',
                "all_$attribute" => 'elements',
                "${singular}_count" => 'count',
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
        FILE:
        for (my $i = 0; $i < $#attributes; $i += 2) {
            my $type = $attributes[$i];
            my $is_required = $attributes[$i + 1];
            my $filename = $attributes[$i + 2];

            if(!$self->directory->child($filename)->exists) {
                next FILE if !$is_required && ;
            }
            $self->parse_file($type, $filename);

            my $singular = type_to_singular($type);
            my $method = "${singular}_count";
        }
        
    }

    method parse_file($type, $filename) {
        my $method = sprintf 'add_%s', type_to_singular($type);
        my $class = sprintf 'Opendata::GTFS::Type::%s', $type->name;

        my $csv = Text::CSV->new( { binary => 1 } );
        my $fh;
        File::BOM::open_bom($fh, $self->directory->child($filename), ':utf8');

        my $column_names = $csv->getline($fh);
        if(!defined $column_names) {
            die sprintf "Can't read the first line of the file. Check %s for errors.", $self->directory->child($filename);
        }
        my @column_names = @{ $column_names };

        LINE:
        while(1) {
            my $line = $csv->getline($fh);
            last LINE if $csv->eof && !defined $line;
            next LINE if !defined $line;

            my @args = zip @column_names, @{ $line };
            $self->$method($class->new(@args));

            last LINE if $csv->eof;
        }

        close $fh or die sprintf "Can't close %s", $self->directory->child($filename);
    }
}
