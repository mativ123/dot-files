#!/bin/bash
open=$(pgrep -x spotify)

if [ ${#open} -gt "7" ]; then
    song=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' | cut -d '"' -f 2)
    song=${song%-*}
    if [ ${#song} -gt "30" ]; then
        song=$(echo $song | cut -c 1-30 | sed -e 's/$/.../')
    fi

    printf "$song"
else
    printf "nothing"
fi
