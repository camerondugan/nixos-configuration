#!/usr/bin/env bash
# Set unstable and home-manager
# sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager # unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager # stable
sudo nix-channel --add https://github.com/pjones/plasma-manager/archive/trunk.tar.gz plasma-manager
# setup catppuccin theming
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin

# Set to unstable channels
sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable

# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-channel --add https://nixos.org/channels/nixos-24.05 stable

# pull down new versions of stuff
sudo nix-channel --update

# Download latest config
nix-shell -p git --run "git clone https://gitlab.com/cameron.dugan/nixos-configuration.git"

# Set config as this one
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s /home/"$USER"/.nixos/configuration.nix /etc/nixos/configuration.nix

# Setup this-device.nix
{
	echo "{ config, pkgs, ... }:

# Copy luks to swap.nix
{"
	grep 'luks' /etc/nixos/configuration.nix.bak
	grep 'hostName' /etc/nixos/configuration.nix.bak
	echo "
}"

} >>~/.nixos/this-device.nix
# Use config
sudo nixos-rebuild switch
# Setup flathub (for extra options but probably won't need)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
