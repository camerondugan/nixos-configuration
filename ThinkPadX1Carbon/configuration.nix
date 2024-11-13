{
  config,
  lib,
  ...
}: {
  imports = [
    ../SoftwareBundles/coder.nix
    ../SoftwareBundles/gamer.nix
    ../HardwareFixes/tlp.nix
    ../HardwareFixes/ssd.nix
  ];

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
