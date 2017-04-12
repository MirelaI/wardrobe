use strict;
use warnings;
use ExtUtils::MakeMaker;

# Normalize version strings like 6.30_02 to 6.3002,
# so that we can do numerical comparisons on it.
my $eumm_version = $ExtUtils::MakeMaker::VERSION;
$eumm_version =~ s/_//;

WriteMakefile(
    NAME                => 'Wardrobe',
    AUTHOR              => q{Mirela Iclodean <<imirela at cpan.org>},
    VERSION_FROM        => 'lib/Wardrobe.pm',
    ABSTRACT            => 'Wardrobe management',
    ($eumm_version >= 6.3001
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Dancer2'                   => 0.153000,
        'Dancer2::Plugin::DBIC'     => 0,
        'Dancer2::Plugin::Deferred' => 0,
        'String::Util'              => 0,
        'Test::More'                => 0,
        'Text::CSV'                 => 0,
        'YAML'                      => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Wardrobe-*' },
);
