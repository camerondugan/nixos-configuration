{
  flake.nixosModules.bootLoader = {
    # Bootloader.
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
