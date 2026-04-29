{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  gaming.enable = true;

  networking.hostName = "Framework13";

  services.fwupd.enable = true;
}
