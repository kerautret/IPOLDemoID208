#!/bin/bash

## DISPLAY type: 0: POINTS
## DISPLAY type: 1: POINTS + LINE
## DISPLAY type: 2: LINE

DATARAW=$2
DATAPOINTS=$1
OUTPUTFILE=$3
TYPE="${OUTPUTFILE##*.}"
echo type="$TYPE"
DISPLAYTYPE=$4
SPEPATH=$5

PLOTFILE='plotLineData.plt'



echo -e "\c" > $PLOTFILE

echo "output file=${OUTPUTFILE}="
if [ "$TYPE" == "png" ]
then
    echo set terminal png size 750,562     >> $PLOTFILE
elif  [ "$TYPE" == "eps" ]
then
    echo "set terminal postscript eps color  20" >> $PLOTFILE
else
    echo "extension $TYPE not processed... exit"
    exit 1;
fi


echo set output \'$OUTPUTFILE\' >> $PLOTFILE
echo set datafile separator \',\' >> $PLOTFILE
echo set parametric >> $PLOTFILE

$SPEPATH/formatPlotSetting.sh $DATARAW  >> $PLOTFILE
echo -e "splot \c " >> $PLOTFILE
if [ $DISPLAYTYPE -eq 0 ] || [ $DISPLAYTYPE -eq 1 ]
then
echo -e  "'$DATAPOINTS' using 1:2:3 with points palette pointsize 0.5 pointtype 6 \c" >> $PLOTFILE
fi

if [ $DISPLAYTYPE -eq 1 ]
then
    echo -e " , \c" >> $PLOTFILE
fi
if [ $DISPLAYTYPE -eq 1 ] || [ $DISPLAYTYPE -eq 2 ]
then
    $SPEPATH/formatPlotLines.sh $DATARAW $DISPLAYTYPE  >> $PLOTFILE
fi

echo $(/usr/bin/gnuplot ${PLOTFILE}) 

exit 0
