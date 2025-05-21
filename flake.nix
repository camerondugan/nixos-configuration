{
  description = "flake for cam (me)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # reduces cosmic build time
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    helix-flake.url = "github:helix-editor/helix";
    helix-flake.inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    nixos-cosmic,
    helix,
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

      extraSpecialArgs = {
        helix-flake = helix;
      };
    };
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Desktop/configuration.nix
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
      framework13 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Framework13/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.framework-13-7040-amd
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
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.common-gpu-nvidia
          nixos-hardware.nixosModules.common-pc-laptop-ssd
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
