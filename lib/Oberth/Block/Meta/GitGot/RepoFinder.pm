use Oberth::Manoeuvre::Common::Setup;
package Oberth::Block::Meta::GitGot::RepoFinder;
# ABSTRACT: RepoFinder strategy that uses GitGot

use Modern::Perl;
use Mu;
use Oberth::Block::Meta::GitGot;
use Oberth::Block::Service::GitHub::Repo;
use Try::Tiny;

has gitgot => (
	is => 'ro',
	default => method() {
		my $gitgot = Oberth::Block::Meta::GitGot->new;
	},
);

lazy _gitgot_github => method() {
	my @gitgot_github = map {
		try {
			die unless defined $_->repo_url;
			+{
				gitgot => $_,
				github_repo => Oberth::Block::Service::GitHub::Repo->new(
					uri => $_->repo_url,
				),
			}
		} catch {
			();
		};
	} @{ $self->gitgot->data };

	\@gitgot_github;
};

lazy _git_scp_to_path => method() {
	+{
		map {
			try {
				$_->{github_repo}->git_scp_uri
					=> $_->{gitgot}->repo_path
			} catch {
				()
			};
		} @{ $self->_gitgot_github }
	};
};

method find_path( $repo ) {
	my $dep_path = $self->_git_scp_to_path->{ $repo->git_scp_uri };
}


1;
