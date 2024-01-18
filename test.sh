#! /bin/sh
sudo nixos-rebuild switch --show-trace --fast
hyprctl reload
