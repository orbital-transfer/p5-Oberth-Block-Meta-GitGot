use Modern::Perl;
package Orbital::Payload::Meta::GitGot;

use Mu;
use Orbital::Transfer::Common::Setup;

use YAML::XS;
use Path::Tiny;
use Try::Tiny;

use Orbital::Payload::Meta::GitGot::Repo;

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
		push @data, Orbital::Payload::Meta::GitGot::Repo->new( data => $repo );
	};

	\@data;
};

1;
