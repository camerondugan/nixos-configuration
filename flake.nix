{
  nixConfig = {
    extra-substituters = [ "https://cosmic.cachix.org/" ];
    extra-trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic }: {
    nixosConfigurations = {
      # NOTE: change "host" to your system's hostname
      Desktop = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-cosmic.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
