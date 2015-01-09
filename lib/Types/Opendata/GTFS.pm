use 5.14.0;
use Moops;

# VERSION
# PODNAME: Types::Opendata::GTFS

library  Types::Opendata::GTFS

extends  Types::Standard,
         Types::Path::Tiny,
         Types::URI

declares Agency
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
