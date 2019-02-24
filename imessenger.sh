#!/usr/bin/env bash
#
# Script name:  imessenger
# Author:   Samuel Naser
#
# Description:
#
#  - Offers a basic command-line interface with iMessage which allows for piped input
#
# Usage:
#
#  curl http://textfiles.com/humor/boston.geog | ./imessage.sh --to "Joe Schmoe"
#


set -o errexit

function usage {
    echo "usage: imessenger [-m message] [--message message] [-t recipient] [--to recipient]"
    echo "  -m message  message to send to recipient, this can be omitted if passing message from stdin"
    echo "  -t recipient    the contact in iMessage who should receive the message"
    exit 1
}

# check deps
command -v osascript >/dev/null 2>&1 || { echo >&2 "Require osascript, but could not locate on system. Aborting."; exit 1; }

# constants
OSASCRIPT=$(which osascript)

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -h | --help )
    usage
    ;;
  -t | --to )
    shift; RECIPIENT=$1
    ;;
  -m | --message )
    shift; MESSAGE=$1
    ;;

esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

if [ -z "$RECIPIENT" ]; then
    echo "Recipient not specified, check command usage"; exit 1;
fi

if [ -z "$MESSAGE" ]; then
    # read msg from stdin if none provided
    STDIN=$(cat)
    if [ -z "$STDIN" ]; then
        echo "Message not specified, check command usage"; exit 1;
    fi
    MESSAGE=$STDIN
fi

OSASCRIPT_SEND_TEMPLATE="$OSASCRIPT -e 'tell application \"Messages\" to send \"$MESSAGE\" to buddy \"$RECIPIENT\"'"
if eval $OSASCRIPT_SEND_TEMPLATE; then
    echo "Success! Message sent through iMessage"; exit 0;
fi

exit 1;