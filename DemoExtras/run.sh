#!/bin/bash

SPEPATH=$1
INPUTDATA=$2 
# output of generated plot file
PLOTFILE=$3
OUTPUT=$4
DATALINE=lines.dat
MAXLINES=$5
MINVOTE=$6
DX=$7 
echo "cmd: $INPUTDATA -o mainResult.txt -gnuplot  $DATALINE -nlines $MAXLINES -minvotes $MINVOTE -dx $DX "
hough3dlines $INPUTDATA -o res.dat -gnuplot  $DATALINE -nlines $MAXLINES -minvotes $MINVOTE -dx $DX


$SPEPATH/DemoExtras/displayLinesData.sh $INPUTDATA $DATALINE resultLines.eps 0 
$SPEPATH/DemoExtras/displayLinesData.sh $INPUTDATA $DATALINE resultLines.png 0

$SPEPATH/DemoExtras/displayLinesData.sh $INPUTDATA $DATALINE resultPointLines.eps 1 
$SPEPATH/DemoExtras/displayLinesData.sh $INPUTDATA $DATALINE resultPointLines.png 1

$SPEPATH/DemoExtras/displayLinesData.sh $INPUTDATA $DATALINE sourcePoint.eps 2 
$SPEPATH/DemoExtras/displayLinesData.sh $INPUTDATA $DATALINE sourcePoint.png 2

echo "done..."

exit 0
