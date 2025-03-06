{
  description = "flake for cam (me)";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nixos-cosmic.url  = "github:lilyinstarlight/nixos-cosmic";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
  };

  outputs = {self, nixpkgs, home-manager, nixos-hardware, nixos-cosmic}:
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
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Desktop/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-cosmic.nixosModules.default
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                ];
              };
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
            nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                ];
              };
	  }
        ];
      };
      razer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Razer/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-cosmic.nixosModules.default
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                ];
              };
	  }
        ];
      };
    };
  };
}
