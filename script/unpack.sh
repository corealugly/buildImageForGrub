#!/bin/bash

set -e 
#----------------------
CURRENT_PATH=$(pwd)
ROOT_PATH=$(dirname $0)
cd ${ROOT_PATH}

function view_out {
        echo "NOTE: ${1}"
}
#----------------------
#source ./source.sh


#iso_image=$(find ../iso/ -name "${1}")
#if [[ "${1}" != "" ]]; then mount ${CURRENT_PATH}/${1} ../iso_mount/; ls -la ../iso_mount/; exit 1; fi
if [[ "${1}" != "" ]] 
then
	iso_image=$(find ../iso/ -name "${1}")
	mount ${iso_image} ../iso_mount/
	ls -la ../iso_mount/
#	exit 1
fi

if (( $(du -s  ../iso_mount/ | awk '{print $1}') < 100 )); then view_out "not mount"; exit 1; fi  

squashfs=$(find ../iso_mount/ -name "*squashfs*")
unsquashfs -d ../squashfs  -f ${squashfs}

initramfs=$(find ../iso_mount/ -name "*igz*" | grep -i "isolinux")
cd ../initramfs/ && xz -dc ${initramfs} | cpio -idv && cd -
