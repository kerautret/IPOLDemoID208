#!/bin/bash

SPEPATH=$1
INPUTDATA=$2 
# output of generated plot file
PLOTFILE=$3
OUTPUT=$4
DATALINE=lines.dat

CMDFILE=cmd.txt

MAXLINES=$5
MINVOTE=$6
DX=$7 

CMD1="hough3dlines $INPUTDATA  -raw  -nlines $MAXLINES -minvotes $MINVOTE -dx $DX >  $DATALINE"
CMD2="hough3dlines $INPUTDATA  -gnuplot  -nlines $MAXLINES -minvotes $MINVOTE -dx $DX |gnuplot -persist"

eval $CMD1

ISFINE=$?
if [ $ISFINE -eq 1 ]
then
    >&2 echo "(dx = $DX)"
    >&2 echo "------------------------" 
    >&2 echo "You can set dx to 0 to automatically define this parameter ( i.e it will use dx = (1/64)*(input bounding box size) )."
    >&2 echo "------------------------" 
    
    exit 1
fi

echo $CMD2 > $CMDFILE



$SPEPATH/DemoExtras/displayLines.sh $INPUTDATA $DATALINE resultLines.eps 2 $SPEPATH/DemoExtras 
$SPEPATH/DemoExtras/displayLines.sh $INPUTDATA $DATALINE resultLines.png 2 $SPEPATH/DemoExtras

$SPEPATH/DemoExtras/displayLines.sh $INPUTDATA $DATALINE sourcePoint.eps 0 $SPEPATH/DemoExtras
$SPEPATH/DemoExtras/displayLines.sh $INPUTDATA $DATALINE sourcePoint.png 0 $SPEPATH/DemoExtras


$SPEPATH/DemoExtras/displayLines.sh $INPUTDATA $DATALINE resultPointLines.eps 1 $SPEPATH/DemoExtras
$SPEPATH/DemoExtras/displayLines.sh $INPUTDATA $DATALINE resultPointLines.png 1 $SPEPATH/DemoExtras

$SPEPATH/DemoExtras/formatPlotLines.sh $DATALINE 3 > mainOutput.txt 


echo "done..."

exit 0
