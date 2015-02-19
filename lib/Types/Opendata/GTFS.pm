use 5.14.0;
use Moops;

# VERSION:
# ABSTRACT: Types for Opendata::GTFS
# PODCLASSNAME

library  Types::Opendata::GTFS

extends  Types::Standard,
         Types::Path::Tiny,
         Types::URI

{
    class_type Agency        => { class => 'Opendata::GTFS::Type::Agency' };
    class_type Calendar      => { class => 'Opendata::GTFS::Type::Calendar' };
    class_type CalendarDate  => { class => 'Opendata::GTFS::Type::CalendarDate' };
    class_type FareAttribute => { class => 'Opendata::GTFS::Type::FareAttribute' };
    class_type FareRule      => { class => 'Opendata::GTFS::Type::FareRule' };
    class_type Frequency     => { class => 'Opendata::GTFS::Type::Frequency' };
    class_type Route         => { class => 'Opendata::GTFS::Type::Route' };
    class_type Shape         => { class => 'Opendata::GTFS::Type::Shape' };
    class_type Stop          => { class => 'Opendata::GTFS::Type::Stop' };
    class_type Transfer      => { class => 'Opendata::GTFS::Type::Transfer' };
    class_type StopTime      => { class => 'Opendata::GTFS::Type::StopTime' };
    class_type Trip          => { class => 'Opendata::GTFS::Type::Trip' };
}

1;

__END__

=pod

=encoding utf-8

=head1 TYPES

=for :list
* L<Agency|Opendata::GTFS::TypeAgency>
* L<Calendar|Opendata::GTFS::Type::Calendar>
* L<CalendarDate|Opendata::GTFS::Type::CalendarDate>
* L<FareAttribute|Opendata::GTFS::Type::FareAttribute>
* L<FareRule|Opendata::GTFS::Type::FareRule>
* L<Frequency|Opendata::GTFS::Type::Frequency>
* L<Route|Opendata::GTFS::Type::Route>
* L<Shape|Opendata::GTFS::Type::Shape>
* L<Stop|Opendata::GTFS::Type::Stop>
* L<Transfer|Opendata::GTFS::Type::Transfer>
* L<StopTime|Opendata::GTFS::Type::StopTime>
* L<Trip|Opendata::GTFS::Type::Trip>

=cut
