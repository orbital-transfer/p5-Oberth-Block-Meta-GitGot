use Orbital::Transfer::Common::Setup;
package Orbital::Payload::Tool::GitGot;
# ABSTRACT: Process data from App::GitGot

use Orbital::Transfer::Common::Setup;
use Mu;

use YAML;

use Orbital::Payload::Tool::GitGot::Repo;

has config_path => (
	is => 'ro',
	default => sub { path('~/.gitgot') },
);

lazy _gitgot => method() {
	my $gitgot = YAML::LoadFile( $self->config_path );
};

lazy data => method() {
	my @data;
	for my $repo ( @{ $self->_gitgot } ) {
		push @data, Orbital::Payload::Tool::GitGot::Repo->new( data => $repo );
	};

	\@data;
};

1;
