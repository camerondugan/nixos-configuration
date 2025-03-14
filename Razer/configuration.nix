{config, ...}: {
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

  # Enable swap on luks
  boot.initrd.luks.devices."luks-fa7ee9e1-264f-4516-83c0-74403f35232e".device = "/dev/disk/by-uuid/fa7ee9e1-264f-4516-83c0-74403f35232e";

  services = {
    thermald.enable = true;
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

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
