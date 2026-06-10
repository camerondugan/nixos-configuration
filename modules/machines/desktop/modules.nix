{ self, inputs, ... }:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # Desktop Specific
      self.nixosModules.desktopConf
      self.nixosModules.desktopHardware
      # Required
      self.nixosModules.nix-settings
      self.nixosModules.home-manager
      self.nixosModules.stateVersion
      self.nixosModules.bootLoader
      self.nixosModules.users
      self.nixosModules.shell
      self.nixosModules.rmtrash
      self.nixosModules.time-zone
      self.nixosModules.scx
      # Declare that this nixos system uses unfree software
      self.nixosModules.unfree
      # Chaotic Required
      inputs.chaotic.nixosModules.default
      self.nixosModules.cachyos
      # Optional Services
      self.nixosModules.syncthing
      self.nixosModules.ollama
      self.nixosModules.ollama-cuda
      # Optional Programs
      self.nixosModules.browser
      self.nixosModules.anki
      self.nixosModules.fish
      self.nixosModules.cosmic
      self.nixosModules.office
      self.nixosModules.gaming
      self.nixosModules.flatpak
      self.nixosModules.nix-dev
    ];
  };
}
