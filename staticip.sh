#!/bin/bash
#this file gives the isolinux.cfg a static ip address if you don't need a static address just use the cdbuild.sh by itself

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 2 ] || die "2 arguments required, $# provided, Usage: ./staticip 192.168.3.4 iso_prefix_name" 

IP=$1
PREFIX=$2
NETMASK=`echo "$IP" | cut -d. -f1,2,3`
INFILE=isolinux.cfg.static
OUTFILE=$PREFIX.cfg

sed -e "s/ip=[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/"ip=$IP"/g" -e "s/gateway=[0-9]*\.[0-9]*\.[0-9]*/gateway=$NETMASK/g" -e "s/el6.base.ks/el6.$PREFIX.ks/g" $INFILE > $OUTFILE
cp $OUTFILE isolinux.cfg
./cdbuild.sh $PREFIX

#Restoring stock template
cp isolinux_template.cfg isolinux.cfg
