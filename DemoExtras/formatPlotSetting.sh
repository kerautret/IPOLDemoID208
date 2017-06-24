#!/bin/bash
# Analyse the header (bouding box and range)and extract it in the format for splot

INPUT_NAME=$1

XMIN=0
XMAX=0
YMIN=0
YMAX=0
ZMIN=0
ZMAX=0

URANGE_MIN=0;
URANGE_MAX=0;

NUM=0
while read line; do
    ## processing line 0 (get BB)
    if [ $NUM -eq 0 ] && [ "$line" != "" ]
    then
        set -- $line
        XMIN=$1
        XMAX=$2
        YMIN=$3
        YMAX=$4
        ZMIN=$5
        ZMAX=$6
    fi
    ## getting urange
    if [ $NUM -eq 1 ] && [ "$line" != "" ]
    then
        set -- $line
        URANGE_MIN=$1
        URANGE_MAX=$2
    fi
    if [ $NUM -gt 1 ] 
    then
        break;
    fi
    
    NUM=$(($NUM+1))
done < $INPUT_NAME


echo "set xrange [$XMIN:$XMAX]"
echo "set yrange [$YMIN:$YMAX]"
echo "set zrange [$ZMIN:$ZMAX]"
echo "set urange [$URANGE_MIN:$URANGE_MAX]"



