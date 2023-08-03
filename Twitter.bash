%%file twitterViewerEditor.sh

#!/bin/bash

MENU=$'\n+-------------+----------------------------------------------------------+\n|   Command   |                      Description                         |\n+-------------+----------------------------------------------------------+\n|      c      | Create tweet by giving its “text”                        |\n|  r <number> | Read the tweet with ID <number>                          |\n|  u <number> | Update the tweet with ID <number> by giving its new text |\n|      d      | Delete current tweet                                     |\n|      $      | Read the last tweet in the file                          |\n|      -      | Read one tweet up from the current tweet                 |\n|      +      | Read one tweet down from your current tweet              |\n|      =      | Print current tweet ID                                   |\n|      q      | Quit without save                                        |\n|      w      | (Over)write file to disk                                 |\n|      x      | Exit and save                                            |\n+-------------+----------------------------------------------------------+\n\n'
FILE="tweetsmall.txt"
TMP_FILE="tmp.txt"
BAD_INPUT=$"Bad input... Please try again"
NO_ID=$"No tweet ID was provided..."
CURRENT_TWEET=1

print_menu() {
    echo "${MENU}"
    echo "Please enter the desired command: "
    local USER_CHOICE
    read USER_CHOICE
    #breaks up the user's input based on delimiters i think
    local CHOICE_ARRAY=($USER_CHOICE)
    case_picker ${CHOICE_ARRAY[0]} ${CHOICE_ARRAY[1]}
}



case_picker() {
    local COMMAND=$1
    local ID=$2

    case $COMMAND in

        "c" | "C")
            create_tweet
            ;;
        "r" | "R")
            if [ -z "$ID" ]
                then 
                echo $NO_ID
                echo $BAD_INPUT
                print_menu
            fi
            read_tweet $ID
            ;;
        "u" | "U")
            update_tweet $ID
            ;;
        "d" | "D")
            delete_tweet
            ;;
        "$")
            read_last_tweet
            ;;
        "-")
            read_one_up
            ;;
        "+")
            read_one_down
            ;;
        "=")
            print_current_tweet_id
            ;;
        "q" | "Q")
            quit_without_saving
            ;;
        "w" | "W")
            write_to_file
            ;;
        "x" | "X")
            save_and_exit
            ;;
        *)
            echo $BAD_INPUT
            print_menu
            ;;
    esac

}

create_copy() {
    cp $FILE $TMP_FILE
}

create_tweet() {
    local NEW_TWEET
    echo "Please enter tweet text: "
    read NEW_TWEET
    echo ${NEW_TWEET} >> $TMP_FILE
    CURRENT_TWEET="$(wc -l < $TMP_FILE)"
    print_menu
}

read_tweet() {
    CURRENT_TWEET=$1
    echo `sed "${CURRENT_TWEET}q;d" $TMP_FILE`
    print_menu
}

update_tweet(){
    local NEW_TWEET
    echo "Please enter tweet text: "
    read NEW_TWEET
    
    CURRENT_TWEET=$1
    local AUX_FILE="delete_me.txt"
    local i=1
    while read -r line
    do
      if [ $i -eq $CURRENT_TWEET ]
        then
            echo "$NEW_TWEET" >> $AUX_FILE
        else
            echo "$line" >> $AUX_FILE
    fi
      ((i++))
    done < "$TMP_FILE"
    rm $TMP_FILE
    mv $AUX_FILE $TMP_FILE
}

delete_tweet() {
    local NUM_OF_LINES="$(wc -l < $TMP_FILE)"
    sed -i "${CURRENT_TWEET}d" $TMP_FILE
    if [ $NUM_OF_LINES -eq $CURRENT_TWEET ]
        then
            CURRENT_TWEET="$(wc -l < $TMP_FILE)"
    fi
}

read_last_tweet() {
    CURRENT_TWEET=`wc -l < $TMP_FILE`
    read_tweet $CURRENT_TWEET
}

read_one_up() {
    local NUM_OF_LINES="$(wc -l < $TMP_FILE)"
    if [ $CURRENT_TWEET -eq $NUM_OF_LINES ]
        then
            echo "Current tweet is set to the last tweet in the file, can't read one up!"
            print_menu
        else
            ((CURRENT_TWEET++))
            read_tweet $CURRENT_TWEET
    fi
}

read_one_down() {
    if [ $CURRENT_TWEET -eq 1 ]
        then
            echo "Current tweet is set to 1 (first tweet in the file), can't read one down!"
            print_menu
        else
            ((CURRENT_TWEET--))
            read_tweet $CURRENT_TWEET
    fi
}

print_current_tweet_id() {
    echo "Current tweet id: ${CURRENT_TWEET}"
}

quit_without_saving() {
    echo "Thank you for using our twitter viewer! Quitting..."
    if [ -f "$TMP_FILE" ] 
        then
            rm $TMP_FILE
    fi
    exit 1
}

write_to_file() {
    echo "Saving...."
    rm $FILE
    mv $TMP_FILE $FILE
}

save_and_exit() {
    write_to_file
    quit_without_saving
    exit 1
}

main() {
    create_copy
    while true;
    do
    print_menu
    done
}

main
