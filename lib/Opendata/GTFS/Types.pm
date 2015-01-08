use 5.14.0;
use Moops;

# VERSION
# PODNAME: Opendata::GTFS::Types

library  Opendata::GTFS::Types

extends  Types::Standard,
         Types::Path::Tiny

declares Agency
{
    class_type Agency   => { class => 'Opendata::GTFS::Feed::Parser::Agency' };
    class_type Route    => { class => 'Opendata::GTFS::Feed::Parser::Route' };
    class_type Stop     => { class => 'Opendata::GTFS::Feed::Parser::Stop' };
    class_type Trip     => { class => 'Opendata::GTFS::Feed::Parser::Trip' };
}
