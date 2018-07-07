#!/bin/bash

#------------------------
function view_out {
        echo "NOTE: ${1}"
}

ROOT_PATH=$(dirname $0)
cd ${ROOT_PATH}
#------------------------

view_out "unmount dir..."
all_mount=$(find ../*  -maxdepth 0 -type d -name "*mount*")
for idx in ${all_mount};
do
#	echo ${idx}
	umount ${idx}
done


view_out "clear dir..."
all_dir=$(find ../*  -maxdepth 0 -type d ! -name "." ! -name "*mount*" ! -name "*script*" ! -name  "iso")
for idx in ${all_dir};
do
	view_out "remove ${idx}/*"
	rm -rf ${idx}/*
done
