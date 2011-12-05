package Github::Score;
use strict;
use warnings;
use LWP;
use JSON;
use HTTP::Request;
use URI;

our $VERSION = '0.001';
$VERSION = eval $VERSION;

=head1 NAME

Github::Score - Get the usernames and number of commits to a github project to 'score' them

=head1 SYNOPSIS

  use strict;
  use Github::Score;

  my $gs = Github::Score->new( user => 'arcanez', repo => 'github-score' );
  my $scores = $gs->scores;

  my $gs = Github::Score->new( url => 'arcanez/github-score' );
  my $scores = $gs->scores;

  my $gs = Github::Score->new( 'arcanez/github-score' );
  my $socres = $gs->scores;

=head1 DESCRIPTION

Github::Score is a thin wrapper around the Github API.

It simply returns the committers (contributors) and number of 
commits (contributions) they have made to a specific github
project in HASH ref form.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no exception.

=head1 SEE ALSO

http://github-high-scores.heroku.com/ - 'inspiration' for this module
https://github.com/leereilly/github-high-scores - source for above mentioned

=head1 AUTHOR

Justin Hunter <justin.d.hunter@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Justin Hunter

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

sub new {
  my $self = shift;
  my @args = @_;

  unshift @args, 'url' if @args % 2 && !ref($args[0]);

  my %args = ref($args[0]) ? %{$args[0]} : @args;
  if (exists $args{url}) {
    ($args{user}, $args{repo}) = (split /\//, delete $args{url});
  }

  my $timeout = $args{timeout} || 10;

  bless { user => $args{user}, repo => $args{repo}, timeout => $timeout }, $self;
}

sub ua { LWP::UserAgent->new( timeout => $_[0]->timeout, agent => join ' ', ( __PACKAGE__, $VERSION ) ); }
sub user { $_[0]->{user} }
sub repo { $_[0]->{repo} }
sub timeout { $_[0]->{timeout} }
sub uri { URI->new( sprintf( 'http://github.com/api/v2/json/repos/show/%s/%s/contributors', $_[0]->user, $_[0]->repo ) ); }
sub json { JSON->new->allow_nonref }

sub scores {
  my $self = shift;
  
  my $response = $self->ua->request( HTTP::Request->new( GET => $self->uri->canonical ) );
  return {} unless $response->is_success;

  my %scores;
  my $contributors = $self->json->decode( $response->content )->{contributors};

  map { $scores{$_->{login}} = $_->{contributions} } @$contributors;
  return \%scores;
}

1;
