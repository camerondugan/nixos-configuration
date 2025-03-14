{...}: {
  imports = [
    ./hardware-configuration.nix
    ../Software/coder.nix
    ../Software/gamer.nix
    ../HardwareFixes/tlp.nix
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
