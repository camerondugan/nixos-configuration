{ config, lib, pkgs, modulesPath, ...}:

{
  networking.hostName = "Desktop"; # Define your hostname.
  # Enable swap on luks
  boot.initrd.luks.devices."luks-0901906b-019c-4d9c-aaf1-5a0a4eaf7ea3".device = "/dev/disk/by-uuid/0901906b-019c-4d9c-aaf1-5a0a4eaf7ea3";
  boot.initrd.luks.devices."luks-0901906b-019c-4d9c-aaf1-5a0a4eaf7ea3".keyFile = "/crypto_keyfile.bin";
}
