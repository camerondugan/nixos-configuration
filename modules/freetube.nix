{
  flake.nixosModules.freetube = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ freetube ];
  };
}
