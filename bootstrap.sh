#!/bin/sh
set -e

if [ `id -u` != "0" ] ; then
    echo "Need to run as root privlege"
    exit 2
fi
apt-add-repository --yes ppa:zfs-native/stable
apt-get update
apt-get install --yes debootstrap spl-dkms zfs-dkms ubuntu-zfs

modprobe zfs
set +e
dmesg | grep ZFS
if [ $? -ne 0 ] ; then
    echo "ZFS did not load correctly, fail fail fail"
    exit 2
fi
set -e

echo "Installed ZFS modules"
exit 0
