use Orbital::Transfer::Common::Setup;
package Orbital::Payload::Tool::GitGot;
# ABSTRACT: Process data from App::GitGot

use Mu;
use Orbital::Transfer::Common::Types qw(AbsFile);

use YAML;

use Orbital::Payload::Tool::GitGot::Repo;

has config_path => (
	is => 'ro',
	isa => AbsFile,
	coerce => 1,
	default => sub { path('~/.gitgot') },
);

lazy _config_data => method() {
	YAML::LoadFile( $self->config_path );
};

lazy repos => method() {
	[ map Orbital::Payload::Tool::GitGot::Repo->new( data => $_ ),
			$self->_config_data->@* ]
};

1;
