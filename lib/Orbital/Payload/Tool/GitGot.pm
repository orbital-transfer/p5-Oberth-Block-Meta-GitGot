use Orbital::Transfer::Common::Setup;
package Orbital::Payload::Tool::GitGot;
# ABSTRACT: Process data from App::GitGot

use Orbital::Transfer::Common::Setup;
use Mu;

use YAML::XS;

use Orbital::Payload::Tool::GitGot::Repo;

has gitgot_config_path => (
	is => 'ro',
	default => sub { path('~/.gitgot') },
);

lazy _gitgot => method() {
	local $YAML::XS::Boolean = "boolean";
	my $gitgot = YAML::XS::LoadFile( $self->gitgot_config_path );
};

lazy data => method() {
	my @data;
	for my $repo ( @{ $self->_gitgot } ) {
		push @data, Orbital::Payload::Tool::GitGot::Repo->new( data => $repo );
	};

	\@data;
};

1;
