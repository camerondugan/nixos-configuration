{
  description = "flake for cam";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
  };

  outputs = {self, nixpkgs, home-manager, nixos-hardware}:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.cam = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home-manager.nix
        ];
      };
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./ThinkPadX1Carbon/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
        ];

      };
    };
  };
}
