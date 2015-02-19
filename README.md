# NAME

Opendata::GTFS::Feed - Parse General Transit Feeds (GTFS)

# VERSION

Version 0.0102, released 2015-02-19.

# SYNOPSIS

    use Opendata::GTFS::Feed;
    my $feed = Opendata::GTFS::Feed->parse(file => 'a-gtfs-feed.zip', directory => 'feed');

# DESCRIPTION

Opendata::GTFS::Feed is an easy way to parse [GTFS](https://developers.google.com/transit/gtfs/) feeds.

# ATTRIBUTES

All list attributes has the [Array](https://metacpan.org/pod/Moose::Meta::Attribute::Native::Trait::Array) trait. Currently the following public methods are created for those attributes:

- `elements` -> `all_$attribute`, where `$attribute` is the attribute name.
- `count` -> `count_$attribute`

## file

## url

## directory

## agencies

## calendar\_dates

## calendars

## fare\_attributes

## fare\_rules

## frequencies

## routes

## shapes

## stop\_times

## stops

## transfers

## trips

# SOURCE

[https://github.com/Csson/p5-Opendata-GTFS-Feed](https://github.com/Csson/p5-Opendata-GTFS-Feed)

# HOMEPAGE

[https://metacpan.org/release/Opendata-GTFS-Feed](https://metacpan.org/release/Opendata-GTFS-Feed)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson <info@code301.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
