#!/usr/bin/env bash
sudo nix-channel --update
sudo nixos-rebuild switch --show-trace --fast
# hyprctl reload
# pkill waybar && (waybar >>/dev/null) &
# disown $!
