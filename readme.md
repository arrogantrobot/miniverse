Miniverse
========

Miniverse is a small tool to help create an ext4 file system within a file.
The filesystem is mounted as a loop device, and can be used for any purpose
a regular filesystem can.

I have used this tool for testing the behavior of software when a disk becomes
full. These conditions can be hard to replicate in testing, and this allows
the user to effortlessly create a filesystem of an exact size, tailor-made
for recreating that odd example where the header of your file can be written
to disk, but then the first write of the body is rejected. Or what-have-you.
Fill in any low disk space scenario and test away.
