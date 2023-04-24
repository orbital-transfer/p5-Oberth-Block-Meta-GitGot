use Orbital::Transfer::Common::Setup;
package Orbital::Payload::Tool::GitGot::RepoFinder;
# ABSTRACT: RepoFinder strategy that uses GitGot

use Orbital::Transfer::Common::Setup;
use Mu;
use Orbital::Payload::Tool::GitGot;
use Orbital::Payload::Serv::GitHub::Repo;

has gitgot => (
	is => 'ro',
	default => method() {
		my $gitgot = Orbital::Payload::Tool::GitGot->new;
	},
);

lazy _gitgot_github => method() {
	my @gitgot_github = map {
		try_tt {
			die unless defined $_->repo_url;
			+{
				gitgot => $_,
				github_repo => Orbital::Payload::Serv::GitHub::Repo->new(
					uri => $_->repo_url,
				),
			}
		} catch_tt {
			();
		};
	} @{ $self->gitgot->data };

	\@gitgot_github;
};

lazy _git_scp_to_path => method() {
	+{
		map {
			try_tt {
				$_->{github_repo}->git_scp_uri
					=> $_->{gitgot}->repo_path
			} catch_tt {
				()
			};
		} @{ $self->_gitgot_github }
	};
};

method find_path( $repo ) {
	my $dep_path = $self->_git_scp_to_path->{ $repo->git_scp_uri };
}


1;
