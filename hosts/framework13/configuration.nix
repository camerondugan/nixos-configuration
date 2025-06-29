{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../home-modules
  ];

  networking.hostName = "Framework13";

  services.fwupd.enable = true;
}
