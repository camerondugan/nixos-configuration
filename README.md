# My Personal Development and Entertainment System

This repo is capable of regenerating my entire system with the exception of what's in my HOME folder.
I hope this also provides new nixos users a good starting point for what their configuration can be.

## Setup:

1. Download the gui nixos install iso and flash it to a usb
2. Install nixos on your machine or vm with swap and hibernate and preferably encrypted disk
3. Boot into your new nixos machine and download the one-time-setup.sh file
4. Make it executable and run it.
5. Wait for it to finish!

## Important Notes:

1. Your /etc/nixos/configuration.nix will now be a shortcut to ~/.nixos/configuration.nix
2. If you are using the encrypted hard-drive feature (which you probably should), ~/.nixos/swap.nix is essential for your machine to reboot. If it fails you can always choose a previous config on startup to restore your machine.
3. Updates your nix system to unstable, which you may not want, feel free to edit the one-time-setup.sh script to exclude that step (still need home-manager unless you want to do a lot of removing lines of my config)
3. I recommend if you want to manage your own repo of this that you keep your hardware-specific(anything that a specific machine of yours needs that the others don't) changes in swap.nix as it gets ignored by .gitignore

Good luck!
**(I am not responsible for what you do to your computer)**

