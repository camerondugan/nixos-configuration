#! /bin/sh
# Set unstable and home-manager
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager

# Set to unstable channels
sudo nix-channel --add https://nixos.org/channels/nixos-23.11 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --update

# Download latest config
nix-shell -p git --run "git clone https://gitlab.com/cameron.dugan/nixos-configuration.git"
# Set config as this one
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s /home/$USER/.nixos/configuration.nix /etc/nixos/configuration.nix
# Setup Swap.nix
echo "{ config, pkgs, ... }:

# Copy luks to swap.nix
{" >>~/.nixos/swap.nix
cat /etc/nixos/configuration.nix.bak | grep 'luks' >>~/.nixos/swap.nix
cat /etc/nixos/configuration.nix.bak | grep 'hostName' >>~/.nixos/swap.nix
echo "
}" >>~/.nixos/swap.nix
# Use config
sudo nixos-rebuild switch
# Setup flathub (for extra options but probably won't need)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
