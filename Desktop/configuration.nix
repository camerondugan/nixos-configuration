{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../Software
    # ../HardwareFixes/tlp.nix
  ];
  gamer.enable = true;

  networking.hostName = "Desktop";

  services = {
    ollama.package = pkgs.ollama-cuda;
  };

  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 40 * 1024; #GB
  #   }
  # ];

  hardware.nvidia.open = true;
}
