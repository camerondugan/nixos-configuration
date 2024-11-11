{
  config,
  lib,
  ...
}: {
  imports = [
    ../SoftwareBundles/coder.nix
    ../SoftwareBundles/gamer.nix
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
}
