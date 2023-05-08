#!/bin/bash

album=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/album/{n;p}' | cut -d '"' -f 2 | head -n 1)
album=${album// }
album=${album//\/}

if [ ! -f "/home/mathias/.config/conky/scripts/lua/albumart/$album.jpg" ]; then
    url=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | grep -A 1 "artUrl" | tail -n 1 | cut -c43-)
    url=${url//\"}
    wget -q $url -O "/home/mathias/.config/conky/scripts/lua/albumart/$album.jpg"
fi

echo "/home/mathias/.config/conky/scripts/lua/albumart/$album.jpg"
