use Orbital::Transfer::Common::Setup;
package Orbital::Payload::Tool::GitGot::Repo;
# ABSTRACT: GitGot repo

use Mu;
use Sub::HandlesVia;

has data => (
	is => 'ro',
	required => 1,
	handles_via => 'Hash',
	handles => {
		url  => [ 'get', 'repo' ],
		path => [ 'get', 'path' ],
		name => [ 'get', 'name' ],
		type => [ 'get', 'type' ],
	},
);

lazy tags => method() {
	[ split ' ', ($self->data->{tags} // '') ];
};


1;
