#!/bin/bash

DATAPOINTS=$1
DATALINES=$2
OUTPUTFILE=$3
TYPE="${OUTPUTFILE##*.}"
echo type="$TYPE"
DISPLAYTYPE=$4

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
        if [ $DISPLAYTYPE -eq 2 ]
        then 
            echo -e " $line with lines notitle lc rgb \"FFFFFF00\"\c " >> $PLOTFILE
        else
            echo -e " $line with lines notitle\c " >> $PLOTFILE
        fi
    else
        if [ $DISPLAYTYPE -eq 2 ]
        then 
            echo -e ", $line with lines notitle lc rgb \"FFFFFF00\"\c " >> $PLOTFILE
        else
            echo -e ", $line with lines notitle\c " >> $PLOTFILE
        fi
    fi
    FIRST=$(($FIRST+1))
    
done < lines.dat
if [ $DISPLAYTYPE -eq 1 ] || [ $DISPLAYTYPE -eq 2 ]
then
    if [ $FIRST -eq 3 ]
    then 
        echo \'$DATAPOINTS\' using 1:2:3 with points palette pointsize 0.5 pointtype 6 >> $PLOTFILE
    else
        echo , \'$DATAPOINTS\' using 1:2:3 with points palette pointsize 0.5 pointtype 6 >> $PLOTFILE

    fi
fi

if [ $FIRST -eq 3 ] && [ $DISPLAYTYPE -eq 0 ]
then
    echo  \'$DATAPOINTS\' using 1:2:3 with points pointsize 0.5 pointtype 6 lc rgb \"FFFFFF00\" >> $PLOTFILE
fi

echo $(/usr/bin/gnuplot ${PLOTFILE}) 

exit 0
