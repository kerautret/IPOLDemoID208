#!/bin/bash


echo "Test...."

echo "Test. Again. AGAIN....."
echo $(gnuplot --help)
SPEPATH=$1
INPUT=$2 
# output of generated plot file
PLOTFILE=$3
OUTPUT=$4
DATALINE=lines.dat


$(hough3dlines $INPUT -o res.dat -gnuplot  $DATALINE)


$SPEPATH/DemoExtras/displayLinesData.sh $INPUT $DATALINE resultLines.eps  
$SPEPATH/DemoExtras/displayLinesData.sh $INPUT $DATALINE resultLines.png  

echo "done..."

