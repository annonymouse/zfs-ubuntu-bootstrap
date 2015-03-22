#!/bin/sh
set -e
rootdisk=$1
if [ $# -ne 1 ] ; then
    echo " You need more arguments "
    exit 2
fi

if [ -c $rootdisk ] ; then
    echo "$rootdisk isn't a disk"
    exit 2
fi

# Make an MBR for the main disk
parted $rootdisk print

parted -s $rootdisk mktable msdos
parted -s $rootdisk mkpart primary ext2 4MB 260MB
parted -s $rootdisk mkpart primary ext2 261MB "100%"

parted -s $rootdisk set 1 boot on
# need to set partition types to BF and BE
parted $rootdisk print

#mke2fs -m 0 -L /boot/grub -j $rootdisk-part1
