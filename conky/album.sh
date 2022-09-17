#!/bin/bash

open=$(pgrep -x spotify)

if [ ${#open} -gt "7" ]; then
    album=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/album/{n;p}' | cut -d '"' -f 2 | sed '$d')
    if [ ${#album} -gt "30" ]; then
        album=$(echo $album | cut -c 1-30 | sed -e 's/$/.../')
    fi

    printf "$album"
else
    printf "nowhere"
fi
