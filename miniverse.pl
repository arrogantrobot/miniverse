#!/usr/bin/env perl

use strict;
use warnings;

my $blocksize = 512;
my $size_in_mb = $ARGV[1];
my $filename = "$ARGV[0].ext4";
my $mount_point = $ARGV[0];



unless(-e $filename) {
	my $blocks = int( ($size_in_mb * 1024 * 1024) / $blocksize);
	my $cmd = "dd if=/dev/zero of=$filename count=$blocks";
	eval {
		system($cmd);
	};
	if ($@) {
		print "The command did not complete.\n";
		if (-e $filename) {
			unlink($filename);
		}
	}
}
unless(-d $mount_point) {
	mkdir $mount_point;
	unless(-d $mount_point) {
		die "Couldn't create mount point at: $mount_point\n";
	}
}
my $makefs = "/sbin/mkfs -t ext4 -q $filename";

eval {
	system($makefs);
};
if ($@) {
}


my @mounts = `cat /proc/mounts`;

my $loopnum = 0;

map {
	if ($_ =~ m/loop/) {
		$_ =~ m/loop(\d)/;
		$loopnum = $1 + 1;
	}
} @mounts;

my $device = "/dev/loop$loopnum";

my $mount_cmd = "sudo mount -o loop=$device $filename $mount_point";

print $mount_cmd. "\n";
eval {
	system($mount_cmd);
};
if ($@) {
}

print "Done!\n";
exit(0);


