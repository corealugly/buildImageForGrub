#!/bin/bash

function out {
        echo ${1}
}

ROOT_PATH=$(dirname $0)
cd ${ROOT_PATH}

CURRENT_PATH=$(pwd)
#----------------------
level=2
#----------------------

if [ ! -f "/usr/bin/tree" ]; then echo "error: file /usr/bin/tree is not exist"; fi
tree ../ -L ${level}
