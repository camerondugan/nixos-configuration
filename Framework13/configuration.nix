{...}: {
  imports = [
    ./hardware-configuration.nix
    ../Software/coder.nix
    ../Software/gamer.nix
  ];

  networking.hostName = "Framework13";

  services.fwupd.enable = true;
}
