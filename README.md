# My Personal Development and Entertainment System

This repo is capable of regenerating my entire system except things in my home folder.
I use Syncthing to keep my home folder up to date.
I hope this also provides new NixOS users a good starting point for what their configuration can be.

## Setup:

1. Download the GUI NixOS install ISO and flash it to a USB
2. Install NixOS on your machine with swap, hibernate, and preferably encrypted disk
3. Boot into your new NixOS machine and download the one-time-setup.sh file
4. Make it executable and run it.
5. Wait for it to finish!

## Important Notes:

1. Your /etc/nixos/configuration.nix will now be a shortcut to ~/.nixos/configuration.nix
2. If you are using the encrypted hard-drive feature (which you probably should), ~/.nixos/this-device.nix is essential for your machine to reboot. If it fails you can always choose a previous config on startup to restore your machine.
3. Updates your nix system to unstable, which you may not want, feel free to edit the one-time-setup.sh script to exclude that step.
4. I recommend if you want to manage your own repo of this that you keep your hardware-specific changes in this-device.nix as it gets ignored by .gitignore

Good luck!
**(I am not responsible for what you do to your computer)**
