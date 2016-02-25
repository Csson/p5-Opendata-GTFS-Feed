use 5.10.0;
use strict;
use warnings;

package Opendata::GTFS::Feed;

# ABSTRACT: Parse General Transit Feeds (GTFS)
# AUTHORITY
our $VERSION = '0.0201';

use Opendata::GTFS::Feed::Elk;
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
use Types::Opendata::GTFS -types;

use List::UtilsBy qw/zip_by/;
use List::Util qw/any/;
use Path::Tiny;
use MooseX::AttributeDocumented;
use Types::Path::Tiny qw/AbsPath/;
use Types::URI qw/Uri/;
use Types::Standard qw/ArrayRef/;

has file => (
    is => 'ro',
    isa => AbsPath,
    required => 0,
    coerce => 1,
    documentation_order => 1,
    documentation => q{If file is given, the feed in the file will be parsed.},
);
has directory => (
    is => 'ro',
    isa => AbsPath,
    required => 0,
    coerce => 1,
    documentation_order => 3,
    documentation => q{If only directory is given, it is expected to find a fully extracted feed in that directory. If C<directory> is given together with either file or url, the feed will be extracted into that directory (and remain there).},
);
has url => (
    is => 'ro',
    isa => Uri,
    required => 0,
    coerce => 1,
    documentation_order => 1,
    documentation => q{If url is given, the feed at the url will be fetched and parsed.},
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

sub type_to_singular {
    my $type = shift;

    my $name = $type->name;
    $name =~ s{(?<=[a-z])([A-Z])}{_$1}g;
    return lc $name;
}
sub type_to_plural {
    my $type = shift;

    my @names = split /_/ => type_to_singular($type);
    $names[-1] = Lingua::EN::Inflect::PL($names[-1]);
    return join '_' => @names;
}

for (my $i = 0; $i < $#attributes; $i += 3) {
    my $type = $attributes[$i];
    my $attribute = type_to_plural($type);
    my $singular = type_to_singular($type);

    has $attribute => (
        is => 'ro',
        isa => ArrayRef[ $type ],
        traits => ['Array'],
        default => sub { [] },
        init_arg => undef,
        handles => {
            "add_$singular" => 'push',
            "all_$attribute" => 'elements',
            "count_$attribute" => 'count',
        },
        documentation_default => '[]',
    );
}

around BUILDARGS => sub {
    my $orig = shift;
    my $self = shift;
    my @args = @_;

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
    elsif(exists $args{'url'}) {
        eval "use HTTP::Tiny";
        die "Passing 'url' to Opendata::GTFS::Feed->new requires HTTP::Tiny" if $@;

        my $response = HTTP::Tiny->new->get($args{'url'});

        die sprintf "Can't download %s: %s", $args{'url'}, join (' - ' => $response->{'status'}, $response->{'reason'}) if !$response->{'success'};

        my $filename = $args{'url'};
        $filename =~ s{/?\?.*}{};
        $filename =~ s{.*/([^/]*)$}{$1};
        $filename .= '.zip' if index ($filename, '.') == -1;

        $args{'directory'}->child($filename)->spew($response->{'content'});

        my $x = Archive::Extract->new(archive => $args{'directory'}->child($filename)->stringify);
        $x->extract(to => $args{'directory'}->stringify) or die $x->error;
    }
    $self->$orig(%args);
};

sub BUILD {
    my $self = shift;

    FILE:
    for (my $i = 0; $i < $#attributes; $i += 3) {
        my $type = $attributes[$i];
        my $is_required = $attributes[$i + 1];
        my $filename = $attributes[$i + 2];

        if(!$self->directory->child($filename)->exists) {
            next FILE if !$is_required;
        }
        $self->parse_file($type, $filename);

        my $plural = type_to_plural($type);
        my $method = "count_$plural";
    }
}

sub parse_file {
    my $self = shift;
    my $type = shift;
    my $filename = shift;

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

    # Google's example feed (https://developers.google.com/transit/gtfs/examples/gtfs-feed / https://developers.google.com/transit/gtfs/examples/sample-feed.zip)
    # has a (reported) bug. This fixes that.
    if($type->name eq 'StopTime' && any { $_ eq 'drop_off_time' } @column_names) {
        my $index = first_index { $_ eq 'drop_off_time'} @column_names;

        $column_names[ $index ] = 'drop_off_type' if $index >= 0;
    }

    LINE:
    while(1) {
        my $line = $csv->getline($fh);
        last LINE if $csv->eof && !defined $line;
        next LINE if !defined $line;
        next LINE if scalar @{ $line } == 1 && (!defined $line->[0] || $line->[0] eq ''); # skip empty lines

        my @args = zip_by { @_ } \@column_names, $line;
        $self->$method($class->new(@args));

        last LINE if $csv->eof;
    }

    close $fh or die sprintf "Can't close %s", $self->directory->child($filename);
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding utf-8

:splint classname Opendata::GTFS::Feed

=head1 SYNOPSIS

    use Opendata::GTFS::Feed;
    my $feed = Opendata::GTFS::Feed->parse(file => 'a-gtfs-feed.zip', directory => 'feed');

=head1 DESCRIPTION

Opendata::GTFS::Feed is an easy way to parse L<GTFS|https://developers.google.com/transit/gtfs/> feeds.

=head1 ATTRIBUTES

All list attributes has the L<Array|Moose::Meta::Attribute::Native::Trait::Array> trait. Currently the following public methods are created for those attributes:

=for :list
* C<elements> -E<gt> C<all_$attribute>, where C<$attribute> is the attribute name.
* C<count> -E<gt> C<count_$attribute>

:splint attributes

=cut
