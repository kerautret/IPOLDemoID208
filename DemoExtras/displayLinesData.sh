#!/bin/bash

DATAPOINTS=$1
DATALINES=$2
OUTPUTFILE=$3
TYPE="${OUTPUTFILE##*.}"
echo type="$TYPE"

PLOTFILE='plotLineData.plt'


echo -e "\c" > $PLOTFILE

echo "output file=${OUTPUTFILE}="
if [ "$TYPE" == "png" ]
then
    echo set terminal png size 750,562     >> $PLOTFILE
elif  [ "$TYPE" == "eps" ]
then
    set terminal postscript eps color  20
else
    echo "extension $TYPE not processed... exit"
    exit 1;
fi

echo set output \'$OUTPUTFILE\' >> $PLOTFILE
echo  set datafile separator \',\' >> $PLOTFILE

echo set parametric>> $PLOTFILE
FIRST=0
while read line; do
    if [ $FIRST -le 1 ]
    then
        echo $line >> $PLOTFILE
    elif [ $FIRST -eq 2 ]
    then
         echo $line >> $PLOTFILE
         echo -e "splot \c ">> $PLOTFILE
    elif [ $FIRST -eq 3 ]
    then
         echo -e " $line with lines notitle\c " >> $PLOTFILE
    else
         echo -e ", $line with lines notitle\c " >> $PLOTFILE
    fi
    FIRST=$(($FIRST+1))
    
done < lines.dat
echo , \'$DATAPOINTS\' using 1:2:3 with points palette pointsize 0.5 pointtype 6 >> $PLOTFILE

echo $(/usr/bin/gnuplot ${PLOTFILE}) 

exit 0
