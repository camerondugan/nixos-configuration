{
  description = "flake for cam (me)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # reduces cosmic build time
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    determinate,
    home-manager,
    nixos-hardware,
    nixos-cosmic,
    ...
  }: let
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
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Desktop/configuration.nix
          determinate.nixosModules.default
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          nixos-cosmic.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./ThinkPadX1Carbon/configuration.nix
          determinate.nixosModules.default
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
          nixos-cosmic.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
      razer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Razer/configuration.nix
          determinate.nixosModules.default
          home-manager.nixosModules.home-manager
          nixos-cosmic.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
  };
}
