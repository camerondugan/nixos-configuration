{
  flake.nixosModules.desktopConf = {
    networking.hostName = "Desktop";

    # NVIDIA Fixes
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # remove if firefox crashes
      NVD_BACKEND = "direct";
    };

    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia.NVreg_TemporaryFilePath=/tmp"
    ];

    hardware.nvidia.powerManagement.enable = true;
    hardware.nvidia.open = true;
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    hardware.nvidia.modesetting.enable = true;
    # hardware.nvidia.package = config.boot.kernelPackagesnvidiaPackages.latest;
  };
}
