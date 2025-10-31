{
  description = "NixOS with Cameron Dugan";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs.follows = "nixos-cosmic/nixpkgs"; # reduces cosmic build time
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    helix-flake = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      # url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      # nixos-cosmic,
      helix,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      common-modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations.cam = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;

        modules = [
          stylix.homeModules.stylix
          ./home-manager.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
        };
      };
      nixosConfigurations = {
        inherit system;
        desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/desktop/configuration.nix
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            # nixos-cosmic.nixosModules.default
          ]
          ++ common-modules;
        };
        framework13 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/framework13/configuration.nix
            nixos-hardware.nixosModules.framework-13-7040-amd
            # nixos-cosmic.nixosModules.default
          ]
          ++ common-modules;
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/thinkPadX1Carbon/configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
            # nixos-cosmic.nixosModules.default
          ]
          ++ common-modules;
        };
        razer = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/razer/configuration.nix
            nixos-hardware.nixosModules.common-gpu-nvidia
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            # nixos-cosmic.nixosModules.default
          ]
          ++ common-modules;
        };
      };
    };
}
