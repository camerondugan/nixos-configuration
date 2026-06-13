{
  flake.nixosModules.razerConf = {
    networking.hostName = "Razer";

    # Enable swap on luks
    boot.initrd.luks.devices."luks-fa7ee9e1-264f-4516-83c0-74403f35232e".device = "/dev/disk/by-uuid/fa7ee9e1-264f-4516-83c0-74403f35232e";

    services = {
      thermald.enable = true;
    };

    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia.open = true;
    hardware.nvidia.prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };
}
