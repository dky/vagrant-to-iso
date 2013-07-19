#!/bin/bash

ISO_IN='rhel-server-6.4-x86_64-boot.iso'
ISO_OUT='rhel-custom.iso'
MOUNTDIR=/mnt/cdrom
WORKDIR=/cdbuild
ISO_OUTPUT_DIR=/vagrant

#Insure mkisofs installed
yum -y install mkisofs

mkdir $MOUNTDIR
mount -o loop $ISO_IN $MOUNTDIR
mkdir $WORKDIR

cp -R $MOUNTDIR/isolinux $WORKDIR
cp isolinux.cfg /cdbuild/isolinux/isolinux.cfg
cd $WORKDIR/isolinux

mkisofs -r -T -J -V "Custom Kickstart CD" \
-b isolinux.bin \
-c boot.cat \
-no-emul-boot \
-boot-load-size 4 \
-boot-info-table \
-v -o $ISO_OUTPUT_DIR/$ISO_OUT .
