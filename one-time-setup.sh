# Set unstable and home-manager
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager

# Set to unstable channels
# sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-channel --update

# Download latest config
nix-shell -p git --run "git clone https://gitlab.com/cameron.dugan/nixos-configuration.git"
# Set config as this one
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s /home/$USER/.nixos/configuration.nix /etc/nixos/configuration.nix
# Setup Swap.nix
echo "{ config, pkgs, ... }:

{" >> ~/.nixos/swap.nix
  cat /etc/nixos/configuration.nix.bak | grep 'luks' >> ~/.nixos/swap.nix
  echo "
}" >> ~/.nixos/swap.nix
# Use config
sudo nixos-rebuild switch
