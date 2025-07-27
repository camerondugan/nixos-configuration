{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../home-modules
    # ../HardwareFixes/tlp.nix
  ];
  gaming.enable = true;

  networking.hostName = "Desktop";

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
