{
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../SoftwareBundles/coder.nix
    ../SoftwareBundles/gamer.nix
    ../HardwareFixes/tlp.nix
    ../HardwareFixes/ssd.nix
  ];

  networking.hostName = "ThinkPadX1Carbon";

  services = {
    thermald.enable = true;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
}
