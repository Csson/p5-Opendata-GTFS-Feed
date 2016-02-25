# NAME

Opendata::GTFS::Feed - Parse General Transit Feeds (GTFS)

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-blue.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/Csson/p5-Opendata-GTFS-Feed"><img src="https://api.travis-ci.org/Csson/p5-Opendata-GTFS-Feed.svg?branch=master" alt="Travis status" /></a>
    <a href="http://cpants.cpanauthors.org/dist/Opendata-GTFS-Feed-0.0105"><img src="https://badgedepot.code301.com/badge/kwalitee/Opendata-GTFS-Feed/0.0105" alt="Distribution kwalitee" /></a>
    <a href="http://matrix.cpantesters.org/?dist=Opendata-GTFS-Feed%200.0105"><img src="https://badgedepot.code301.com/badge/cpantesters/Opendata-GTFS-Feed/0.0105" alt="CPAN Testers result" /></a>
    </p>
</div>

# VERSION

Version 0.0105, released 2016-02-25.

:splint classname Opendata::GTFS::Feed

# SYNOPSIS

    use Opendata::GTFS::Feed;
    my $feed = Opendata::GTFS::Feed->parse(file => 'a-gtfs-feed.zip', directory => 'feed');

# DESCRIPTION

Opendata::GTFS::Feed is an easy way to parse [GTFS](https://developers.google.com/transit/gtfs/) feeds.

# ATTRIBUTES

All list attributes has the [Array](https://metacpan.org/pod/Moose::Meta::Attribute::Native::Trait::Array) trait. Currently the following public methods are created for those attributes:

- `elements` -> `all_$attribute`, where `$attribute` is the attribute name.
- `count` -> `count_$attribute`

:splint attributes

# SOURCE

[https://github.com/Csson/p5-Opendata-GTFS-Feed](https://github.com/Csson/p5-Opendata-GTFS-Feed)

# HOMEPAGE

[https://metacpan.org/release/Opendata-GTFS-Feed](https://metacpan.org/release/Opendata-GTFS-Feed)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
