#!/bin/bash
WINDOW_NAME=$1
#echo "NAME = '${WINDOW_NAME}'"

WINDOW_ID=`wmctrl -l | grep "${WINDOW_NAME}" | head -1 | cut -f1 -d" "`
echo "ID = '${WINDOW_ID}'"

#if [[ x${WINDOW_ID} eq "x" ]]; then
if [ -z $WINDOW_ID ]; then
    echo "Window '{WINDOW_NAME}' not found"
    exit 1
fi
#echo $WINDOW_ID
wmctrl -a "${WINDOW_NAME}"
xdotool windowfocus $WINDOW_ID
