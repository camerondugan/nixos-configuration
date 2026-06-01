{ inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.nixosModules.home-manager =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.default
      ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
      environment.systemPackages = with pkgs; [
        home-manager
      ];
    };
}
