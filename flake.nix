{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs.follows = "nixos-cosmic/nixpkgs"; # reduces cosmic build time
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    helix-flake = {
      url = "github:camerondugan/helix-fork-for-pr-requests";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    # Make Hyprland more like a Desktop Environment
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      # inputs.nixpkgs.follows = "nixpkgs"; # comment out if breaks
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      # inputs.nixpkgs.follows = "nixpkgs"; # comment out if breaks
    };
    stylix = {
      # url = "github:nix-community/stylix/release-25.05";
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    customized-pulsemixer = {
      url = "github:camerondugan/pulsemixer/combined";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      caelestia-shell,
      helix,
      home-manager,
      nixos-hardware,
      self,
      stylix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.import-tree ./modules)
        inputs.home-manager.flakeModules.home-manager
      ];
      systems = [
        "x86_64-linux"
      ];
      flake =
        let
          system = "x86_64-linux";
          common-modules = [
            self.nixosModules.configuration
            self.nixosModules.keyd
            self.nixosModules.hypr
            self.nixosModules.gaming
            self.nixosModules.docker
            self.nixosModules.fish
            self.nixosModules.yttui
            # self.nixosModules.distributedBuild
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
              caelestia-shell.homeManagerModules.default
              ./home-manager.nix
            ];

            extraSpecialArgs = {
              inherit inputs;
            };
          };
          nixosConfigurations = {
            inherit system;
            pkgs = pkgs;
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
              specialArgs = {
                inherit inputs;
              };
            };
            framework13 = nixpkgs.lib.nixosSystem {
              inherit system;
              pkgs = pkgs;
              modules = [
                ./hosts/framework13/configuration.nix
                nixos-hardware.nixosModules.framework-13-7040-amd
                # nixos-cosmic.nixosModules.default
              ]
              ++ common-modules;
              specialArgs = {
                inherit inputs;
              };
            };
            thinkpad = nixpkgs.lib.nixosSystem {
              inherit system;
              pkgs = pkgs;
              modules = [
                ./hosts/thinkPadX1Carbon/configuration.nix
                nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
                # nixos-cosmic.nixosModules.default
              ]
              ++ common-modules;
              specialArgs = {
                inherit inputs;
              };
            };
            razer = nixpkgs.lib.nixosSystem {
              inherit system;
              pkgs = pkgs;
              modules = [
                ./hosts/razer/configuration.nix
                nixos-hardware.nixosModules.common-gpu-nvidia
                nixos-hardware.nixosModules.common-pc-laptop-ssd
                # nixos-cosmic.nixosModules.default
              ]
              ++ common-modules;
              specialArgs = {
                inherit inputs;
              };
            };
          };
        };
    };
}
