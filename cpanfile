requires 'perl', '5.014000';

requires 'Moose', '2.0000';
requires 'Moose::Role', '2.0000';
requires 'Kavorka', '0.036';
requires 'Moops', '0.034';
requires 'MooseX::AttributeDocumented';
requires 'MooseX::StrictConstructor';
requires 'List::AllUtils';
requires 'Safe::Isa';
requires 'Throwable::X::Types';
requires 'namespace::clean';
requires 'Sub::Exporter';
requires 'Types::Standard';
requires 'Types::Path::Tiny';
requires 'Types::URI';
requires 'Type::Tiny';
requires 'Path::Tiny';
requires 'Archive::Extract';
requires 'File::BOM';
requires 'File::Temp';
requires 'Lingua::EN::Inflect';
requires 'Text::CSV';

recommends 'Text::CSV_XS';

on test => sub {
    requires 'Test::More', '0.96';
};
