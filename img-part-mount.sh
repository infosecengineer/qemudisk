#!/bin/bash

# This script is a modified version of one found on a blog, if you recognize this please submit a link 
# So this file and repo can be updated to credit original author

if [ $# -ne 3 ] ; then
    echo 'usage: qemu-mount <image-file> <directory> <imgfile-partition>'
    echo 'eg: qemu-mount my_qemu_qcow2.img maintenance 3'
    echo 'Mounts a qemu image file to a directory'
fi

part=img${3}

start=$(fdisk -l ${1} -o Device,Start | grep $part | awk '{print $2}')
sectors=$(fdisk -l ${1} | grep '^Units: sectors of' | awk '{print $(NF-1)}')
offset=$(( $start * $sectors ))

#echo ${part}' will be used and '$offset' is the offset'

[ -d ${2} ] || mkdir ${2}
sudo mount -o loop,offset=$offset ${1} ${2}
