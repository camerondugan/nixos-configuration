{
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../SoftwareBundles/coder.nix
    ../SoftwareBundles/gamer.nix
    # ../HardwareFixes/tlp.nix
    ../HardwareFixes/ssd.nix
  ];

  networking.hostName = "Desktop";

  fileSystems."/FireCuda" = {
    device = "/dev/nvme0n1p1";
    # options = ["nofail" "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  };


  services = {
    thermald.enable = true;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 40 * 1024; #GB
    }
  ];
}
