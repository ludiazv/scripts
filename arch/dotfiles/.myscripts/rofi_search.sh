#!/bin/bash

BROWSER="firefox"
FOCUS="[class=\"Firefox\"] focus"
QUERY="https://google.com/search?q="
HISTORY_FILE=$(dirname "$0")/.rofi_search_history
MAX_HISTORY=3

if [ -z $@ ] ; then
    tac $HISTORY_FILE
else
    $BROWSER "$QUERY$@"
    if [ $? -eq 0 ] ; then
        touch $HISTORY_FILE
         [ -n "$FOCUS" ] &&  i3-msg $FOCUS > /dev/null
        echo "$@" >> $HISTORY_FILE
        hl=$(wc -l < $HISTORY_FILE)
        if [ "$hl" -gt "$MAX_HISTORY" ] ; then
            tail -n $MAX_HISTORY $HISTORY_FILE > $HISTORY_FILE
        fi
    fi
   
fi
