{
  flake.nixosModules.nix-dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nixd
      nil
      alejandra
    ];
  };
}
