{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../home-modules
    # ../HardwareFixes/tlp.nix
  ];
  nix.settings = {
    substituters = ["https://cache.nixos-cuda.org"];
    trusted-public-keys = ["cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M"];
  };
  nixpkgs.config.cudaSupport = true;
  gaming.enable = true;

  networking.hostName = "Desktop";

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # remove if firefox crashes
    NVD_BACKEND = "direct";
  };
  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 40 * 1024; #GB
  #   }
  # ];

  # Suspend fix
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/tmp"
  ];

  services.ollama.enable = true;
  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];

  hardware.nvidia.powerManagement.enable = true;

  hardware.nvidia.open = true;
  # hardware.nvidia.powerManagement.finegrained = true;

  # monitor audio prevent sleep
  # services.pipewire.wireplumber.extraConfig."99-disable-suspend" = {
  #   "monitor.alsa.rules" = [
  #     {
  #       matches = [
  #         {"node.name" = "alsa_output.pci-0000_0a_00.1.hdmi-stereo";}
  #       ];
  #       actions.update-props = {
  #         "session.suspend-timeout-seconds" = 0;
  #         "node.always-process" = true;
  #       };
  #     }
  #   ];
  # };
}
