#!/bin/sh

INPUT=$1
OUTPUTFILE=$2
TITLE=$3
PLOTFILE='tmp.plot'


echo "" > $PLOTFILE
echo set terminal png size 750,562 noenhanced      >> $PLOTFILE

echo set output \'$OUTPUTFILE\' >> $PLOTFILE
echo  set datafile separator \',\' >> $PLOTFILE
echo "splot  '$INPUT' using 1:2:3 with points palette pointsize 1 pointtype 7  title '$INPUT'"  >> $PLOTFILE

$(/usr/local/bin/gnuplot "${PLOTFILE}")

