#!/bin/bash

xset fp+ /usr/local/share/fonts/nerdfonts
xset fp+ /usr/local/share/fonts/terminus
xset fp rehash

xrdb -merge ~/.Xresources

exec dwm
