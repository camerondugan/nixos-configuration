# My Personal Development and Entertainment System

This repository is capable of regenerating my entire system except things in my
home folder. I use SyncThing to keep my home folder up to date. I hope this also
provides other NixOS users a starting point for what their configuration can be.

## Setup

1. Download the GUI NixOS install ISO and flash it to a USB
1. Install NixOS on your machine with swap, hibernate, and preferably encrypted
   disk, but for getting started and easy debugging starting unencrypted is OK too.
1. ??? <you may need to search this part on your own>
1. Profit

## Important Notes

1. Your /etc/nixos/configuration.nix will now be a shortcut to
   ~/.nixos/configuration.nix
2. If you are using the encrypted hard-drive feature (which you probably
   should), ~/.nixos/this-device.nix is essential for your machine to reboot. If
it fails you can always choose a previous config on startup to restore your
machine.
3. Updates your nix system to unstable, which you may not want, feel free to
   edit the one-time-setup.sh script to exclude that step.
4. I recommend if you want to manage your own repository of this that you keep
   your hardware-specific changes in this-device.nix as it gets ignored by
   .gitignore

**(I am not responsible for what you do to your computer)** Good luck :) 
