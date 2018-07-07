#!/bin/bash

set -e 
#----------------------
CURRENT_PATH=$(pwd)
ROOT_PATH=$(dirname $0)
cd ${ROOT_PATH}

function view_out {
echo "note: ${1}"
}
#----------------------

kernel=$(find ../iso_mount/ -name "gentoo" | grep -i "isolinux")
cp -v ${kernel} ../build/

if [[  -d ../initramfs/mnt/ ]] && (( $(du -s  ../squashfs/ | awk '{print $1}') > 100 ));
then 
	view_out "build squashfs..."
	mkdir -p ../initramfs/mnt/cdrom
	mksquashfs ../squashfs  ../initramfs/mnt/cdrom/image.squashfs
fi

view_out "build initramfs..."
cd ../initramfs/ && find . -print | cpio -o -H newc |gzip -9 -c - > ../build/initramfs.gz  && cd -
