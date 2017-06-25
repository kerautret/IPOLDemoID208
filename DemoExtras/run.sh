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

read RES < stderr.txt

if [ "$RES" == "Error: dx too large" ]
then
    echo "bad_dx=1" >> algo_info.txt 
    exit 0;  

else
    echo "bad_dx=0" >> algo_info.txt 
fi

RES=$(echo $RES | cut -d " " -f -5)
echo "ERRRE:$RES";

if [ "$RES" == "Error: cannot allocate memory for" ] || [ "$RES" == "Error: program was compiled in" ]
then
    echo "bad_alloc=1" >> algo_info.txt 
    exit 0;  
else
    echo "bad_alloc=0" >> algo_info.txt 
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
