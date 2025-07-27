{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "Framework13";

  services.fwupd.enable = true;
}
