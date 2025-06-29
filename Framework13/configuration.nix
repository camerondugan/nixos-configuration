{...}: {
  imports = [
    ./hardware-configuration.nix
    ../Software
  ];

  networking.hostName = "Framework13";

  services.fwupd.enable = true;
}
