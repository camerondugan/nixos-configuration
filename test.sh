#! /bin/sh
sudo nixos-rebuild switch --show-trace --fast
hyprctl reload
pkill waybar && (waybar >>/dev/null) &
disown $!
