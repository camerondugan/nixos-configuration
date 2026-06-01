{ ... }:
{
  flake.nixosModules.cachyos =
    { pkgs, lib, ... }:
    {
      # Requires chaotic nixosModule
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos-lts;
    };
}
