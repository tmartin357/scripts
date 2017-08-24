#!/bin/bash

if [ $# -ne 2 ] ; then
    echo "$0: Usage: tess.sh mode dpi"
    echo "Modes: Lineart, Gray, Color"
    echo "DPI:   75, 100, 200, 300, 600"
    exit 1
fi

LANG=eng #replace with your language code
TIME=`date +%F@%T`


mkdir "/tmp/scan-$TIME"
cd "/tmp/scan-$TIME"

echo "Scanning..."
scanimage --batch="%04d.pnm" --source ADF -x 215.9 -y 273 --mode $1 --resolution $2 2>err.log

shopt -s nullglob

for f in *.pnm; do
    echo "Running OCR on $f"
    tesseract -psm 1 -l $LANG $f $f pdf 2>>err.log
done

echo "Joining files into single PDF..."

pdftk *.pdf cat output ~/Scans/$TIME.pdf 2>>err.log

cd /
rm -rf /tmp/scan-$TIME