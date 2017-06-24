#!/bin/bash
# Analyse the header (bouding box and range)and extract it in the format for splot
# DISPLAY type: 2 => BLACK
# DISPLAY type: 1 => RED
# DISPLAY type: 0 => RED
# DISPLAY type: 3 => RAW

INPUT_NAME=$1
DISPLAYTYPE=$2


NUM=0
while read line; do
    ## processing line 0 (get BB)
    if [ $NUM -ge 2 ] 
    then
        set -- $line
        AX=$1
        AY=$2
        AZ=$3
        BX=$4
        BY=$5
        BZ=$6
        NBVOTE=$7
        if [ $DISPLAYTYPE -ne 3 ]        
        then
           BASE="$AX + u * $BX, $AY + u * $BY, $AZ + u * $BZ"

           if [ $DISPLAYTYPE -eq 2 ]
           then 
               BASE="$BASE with lines notitle lc rgb 'black'" 
           else
               BASE="$BASE with lines notitle lc rgb  \"#FFFF0000\"" 
           fi
           if [ $NUM -eq 2 ]
           then
               echo -e "$BASE \c"
           else
               echo -e ", $BASE \c"
           fi
           
        else
            echo  "nbpoints=${NBVOTE}, a=($AX,$AY,$AZ), b=($BX, $BY, $BZ)"
        fi
    fi
    NUM=$(($NUM+1))
done < $INPUT_NAME





