%%file twitterSentimentAnalyser.sh

#!/bin/bash

FILE="tweetsmall.txt"
POSITIVE_FILE="positive.txt"
NEGATIVE_FILE="negative.txt"
RESULT="sentimentpertweet.txt"

decide_sentiment () {
    eval local POSITIVE="$1"
    eval local NEGATIVE="$2"
    eval local LINE_NUM="$3"

    if [ $POSITIVE -gt $NEGATIVE ]
    then
        echo "Tweet at line $LINE_NUM has a positive sentiment" >> $RESULT
    elif [ $POSITIVE -eq $NEGATIVE ]
    then
        echo "Tweet at line $LINE_NUM has a neutral sentiment" >> $RESULT
    else
        echo "Tweet at line $LINE_NUM has a negative sentiment" >> $RESULT
    fi
}

calculate_positive() {
    eval LINE_FED="$1"
    local LINE_ARRAY=($LINE_FED)
    local LINE_ARRAY_LEN=${#LINE_ARRAY[@]}
    local POSITIVE=0

    for (( i_pos=0; i_pos < $LINE_ARRAY_LEN; i_pos++ ))
    do
        while read POS_KEYWORD
        do
            if [ "$POS_KEYWORD" == "${LINE_ARRAY[$i_pos]}" ]
            then
                ((POSITIVE++))
                break
            fi
        done < $POSITIVE_FILE
    done
    return $POSITIVE
}

calculate_negative() {
    eval LINE_FED="$1"
    local LINE_ARRAY=($LINE_FED)
    local LINE_ARRAY_LEN=${#LINE_ARRAY[@]}
    local NEGATIVE=0

    for (( i_neg=0; i_neg < $LINE_ARRAY_LEN; i_neg++ ))
    do
        while read NEG_KEYWORD
        do
            if [ "$NEG_KEYWORD" == "${LINE_ARRAY[$i_neg]}" ]
            then
                ((NEGATIVE++))
                break
            fi
        done < $NEGATIVE_FILE
    done
    return $NEGATIVE
}

main () {
    if [ -f "$RESULT" ] 
    then
        rm $RESULT
    fi
    local j=1
    while read line
    do
        calculate_positive "\${line}"
        local POSITIVE=$?
        calculate_negative "\${line}"
        local NEGATIVE=$?
        decide_sentiment "\${POSITIVE}" "\${NEGATIVE}" "\${j}"

        ((j++)) 
    done < $FILE
}

#currently the program checks if each line in the neg/pos files exists in the line. this is inefficient, we can instead check if each word in the line exists in a file

main