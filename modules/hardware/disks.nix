{
  flake.nixosModules.disks = { pkgs, ... }: {
    boot.kernelModules = [ "sg" ];
    environment.systemPackages = [
      pkgs.makemkv
    ];
  };
}
