#!/usr/bin/env bash

if [ $# -ne 2 ] ; then
    echo "$0: Usage: mountimage.sh file mountpoint"
    exit 1
fi

set -x 

mkdir -p $2
sudo mount $1 $2
