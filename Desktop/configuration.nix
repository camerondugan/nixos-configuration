{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../Software/coder.nix
    ../Software/gamer.nix
    # ../HardwareFixes/tlp.nix
  ];

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
