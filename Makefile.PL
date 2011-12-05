use strict;
use warnings FATAL => 'all';
use 5.008001;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'Github::Score',
  AUTHOR  => 'Justin Hunter <justin.d.hunter@gmail.com>',
  VERSION_FROM => 'lib/Github/Score.pm',
  LICENSE => 'perl',
  ABSTRACT_FROM => 'lib/Github/Score.pm',
  MIN_PERL_VERSION => '5.008001',
  PREREQ_PM => {
    'HTTP::Request' => 0,
    'JSON' => 0,
    'LWP' => 0,
    'URI' => 0,
  },
  'BUILD_REQUIRES' => {
    'Test::More' => '0.88',
  },
  META_MERGE      => {
    resources => {
      license     => 'http://dev.perl.org/licenses/',
      bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Github::Score',
      repository  => 'https://github.com/arcanez/github-score',
    },
  },
);

