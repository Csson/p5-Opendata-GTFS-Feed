use 5.14.0;
use Moops;

# VERSION
# PODNAME: Opendata::GTFS::Types

library  Opendata::GTFS::Types

extends  Types::Standard,
         Types::Path::Tiny

declares Agency
    {
    class_type Agency   => { class => 'Opendata::GTFS::Parser::Agency' };
}
