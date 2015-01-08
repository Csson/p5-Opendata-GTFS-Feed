use 5.14.0;
use Moops;

# VERSION
# PODNAME: Types::Opendata::GTFS

library  Types::Opendata::GTFS

extends  Types::Standard,
         Types::Path::Tiny

declares Agency
{
    class_type Agency   => { class => 'Opendata::GTFS::Type::Agency' };
    class_type Route    => { class => 'Opendata::GTFS::Type::Route' };
    class_type Stop     => { class => 'Opendata::GTFS::Type::Stop' };
    class_type StopTime => { class => 'Opendata::GTFS::Type::StopTime' };
    class_type Trip     => { class => 'Opendata::GTFS::Type::Trip' };
}
