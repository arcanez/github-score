use Test::More tests => 16;

BEGIN { use_ok 'Github::Score'; }

{
  isa_ok( my $gs = Github::Score->new( user => 'arcanez', repo => 'github-score' ), 'Github::Score' );
  is( $gs->user, 'arcanez' );
  is( $gs->repo, 'github-score' );
}

{
  isa_ok( my $gs = Github::Score->new({ user => 'arcanez', repo => 'github-score' }), 'Github::Score' );
  is( $gs->user, 'arcanez' );
  is( $gs->repo, 'github-score' );
}

{
  isa_ok( my $gs = Github::Score->new( url => 'arcanez/github-score' ), 'Github::Score' );
  is( $gs->user, 'arcanez' );
  is( $gs->repo, 'github-score' );
}

{
  isa_ok( my $gs = Github::Score->new( 'arcanez/github-score' ), 'Github::Score' );
  is( $gs->user, 'arcanez' );
  is( $gs->repo, 'github-score' );
  isa_ok( my $scores = $gs->scores, 'HASH' );
  ok( exists $scores->{arcanez} );
  ok( scalar %$scores );
}
