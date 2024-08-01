{ pkgs, config, ... }:

{
  imports = [
    ../SoftwareBundles/distributedBuilds.nix
    ../SoftwareBundles/coder.nix
  ];
  networking.hostName = "ThinkPad";

  # Enable swap on luks
  boot.initrd.luks.devices."luks-c45223a2-5f52-46a0-b4d3-e81266eee5e3".device = "/dev/disk/by-uuid/c45223a2-5f52-46a0-b4d3-e81266eee5e3";
  boot.initrd.luks.devices."luks-c45223a2-5f52-46a0-b4d3-e81266eee5e3".keyFile = "/crypto_keyfile.bin";

  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";

  # SSD
  services.fstrim.enable = true;
  services.thermald.enable = true;

  # # Start the driver at boot
  # systemd.services.fprintd = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.Type = "simple";
  # };
  #
  # services.fprintd = {
  #   enable = true;
  #   tod.enable = true;
  #   tod.driver = pkgs.libfprint-2-tod1-vfs0090; # driver for 2016 ThinkPads
  # };

  environment.systemPackages = with pkgs; [
    steam
  ];

  #ACPI Call
  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

}
