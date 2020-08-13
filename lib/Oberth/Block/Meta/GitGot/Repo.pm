use Modern::Perl;
package Oberth::Block::Meta::GitGot::Repo;
# ABSTRACT: GitGot repo

use Mu;
use Oberth::Manoeuvre::Common::Setup;

use MooX::HandlesVia;

has data => (
	is => 'ro',
	required => 1,
	handles_via => 'Hash',
	handles => {
		repo_url  => [ 'get', 'repo' ],
		repo_path => [ 'get', 'path' ],
		repo_name => [ 'get', 'name' ],
		repo_type => [ 'get', 'type' ],
	},
);

lazy repo_tags => method() {
	[ split ' ', $self->data->{tags} // '' ];
};


1;
