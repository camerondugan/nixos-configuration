{
  flake.nixosModules.razerHardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd = {
        availableKernelModules = ["xhci_pci" "nvme" "usbhid" "rtsx_pci_sdmmc"];
        kernelModules = [];

        luks.devices."luks-c0f69b1d-3d3e-4dcf-9df7-8dbf14c692f7".device = "/dev/disk/by-uuid/c0f69b1d-3d3e-4dcf-9df7-8dbf14c692f7";
      };
      kernelModules = ["kvm-intel"];
      extraModulePackages = [];
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/5b39fa2e-ad94-43e3-98c6-b029d060fa6f";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/CA2A-97B4";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/8b866e2c-9b10-42bb-b026-5070eb9b0f5e";}
    ];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
