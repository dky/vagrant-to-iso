#!/bin/bash

PREFIX=$1
ISO_IN='rhel-server-6.4-x86_64-boot.iso'
ISO_OUTPUT_DIR=/vagrant
MOUNTDIR=/mnt/cdrom
WORKDIR=/iso-build

if [ -z "$PREFIX" ];
then
	echo "No arguments, using default custom iso"
	ISO_OUT="rhel-custom.iso"
else
	echo "Using $PREFIX as iso naming prefix"
	ISO_OUT="rhel-$PREFIX.iso"
fi

#Check for geniso package
if [ `/bin/rpm -q genisoimage` ];
then
	echo "genisoimage is installed"
else 
	echo "Installing genisoimage"
	yum -y install mkisofs
fi

if [ -d $MOUNTDIR ]; 
then 
	echo "$MOUNTDIR exists"
else
	mkdir $MOUNTDIR
fi

if grep -qs '/mnt/cdrom' /proc/mounts; 
then 
	echo "/mnt/cdrom mounted"
else
	echo "not mounted, mounting /mnt/cdrom"
	mount -o loop $ISO_IN $MOUNTDIR
fi

if [ -d $WORKDIR ]
then
	echo $WORKDIR exists
else
	mkdir $WORKDIR
fi

if [ -f $WORKDIR/isolinux/isolinux.cfg ]
then 
	echo "No need to copy CD-ROM dir over it exists"
	cp isolinux.cfg $WORKDIR/isolinux/isolinux.cfg
else
	echo "Copying ISO over to local dir"
	cp -R $MOUNTDIR/* $WORKDIR
	cp isolinux.cfg $WORKDIR/isolinux/isolinux.cfg
fi

cd $WORKDIR

echo "Generating ISO"
mkisofs -r -T -J -V "Custom Kickstart CD" \
-b isolinux/isolinux.bin \
-c isolinux/boot.cat \
-no-emul-boot \
-boot-load-size 4 \
-boot-info-table \
-v -o $ISO_OUTPUT_DIR/$ISO_OUT .
