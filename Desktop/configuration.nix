{
  config,
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

  fileSystems."/FireCuda" = {
    device = "/dev/nvme1n1p1";
    options = ["nofail"]; # "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  };

  services = {
    ollama.package = pkgs.ollama-cuda;
  };

  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 40 * 1024; #GB
  #   }
  # ];
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.open = true;
}
