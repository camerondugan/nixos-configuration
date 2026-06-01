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
      self.nixosModules.time-zone
      self.nixosModules.scx
      # Chaotic Required
      inputs.chaotic.nixosModules.default
      self.nixosModules.cachyos
      # Optional
      self.nixosModules.syncthing
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
