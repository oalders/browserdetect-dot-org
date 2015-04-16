#!/usr/bin/env perl

# This file is for live deployments.
# usage: perl bin/daemon_control.pl get_init_file > /etc/init.d/browser-detect-dot-org

use strict;
use warnings;

use local::lib '~/perl5';

use Daemon::Control;

my $carton  = 'carton';
my $name    = 'browser-detect-dot-org';
my $user    = 'olaf';
my $group   = 'staff';
my $workers = 3;

my $home = "/Users/olaf/Documents/github/browserdetect-dot-org";
my $pid  = "$home/var/run/$name";
my $port = 5200;

my @args = (
    'exec', 'plackup', '-Ilib',
    '--port'    => $port,
    '-R'        => 'lib',
    '-s',       => 'Starman',
    '-a'        => "$home/app.psgi",
    '--workers' => $workers,
    '-E'        => 'production',
);

my $args = {
    name         => $name,
    directory    => $home,
    program      => $carton,
    program_args => \@args,
    fork         => 2,
    user         => $user,
    group        => $group,
    pid_file     => "$pid.pid",
    stdout_file  => "$home/logs/starman_access.log",
    stderr_file  => "$home/logs/starman_error.log",
    lsb_sdesc    => "Starts $name",
    lsb_desc     => "Starts $name",
};

exit Daemon::Control->new($args)->run;
