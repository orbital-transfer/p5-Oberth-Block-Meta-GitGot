#!/usr/bin/env perl

use Test2::V0;

use Path::Tiny;
use YAML;
use Orbital::Payload::Tool::GitGot;

my $test_data = <<'YAML';
- name: gist/test
  path: /path/to/gist/test
  repo: https://gist.github.com/user/test.git
  tags: gist nopaste
  type: git
- name: git/git
  path: /path/to/git
  repo: git@github.com:git/git.git
  tags: vcs git upstream
  type: git
- name: gnuplot
  path: /path/to/gnuplot
  repo: git://git.code.sf.net/p/gnuplot/gnuplot-main
  tags: sf gnuplot
  type: git
- name: glibc
  path: /path/to/glibc
  repo: git://sourceware.org/git/glibc.git
  type: git
YAML

subtest "Parse test file" => sub {
	my $config_path = Path::Tiny->tempfile;
	$config_path->spew_utf8( $test_data );

	my $got = Orbital::Payload::Tool::GitGot->new( config_path => $config_path );
	is $got->data, bag {
		prop size => 4;
		etc();
	};
};

done_testing;
