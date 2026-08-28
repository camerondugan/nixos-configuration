{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # Desktop Specific
      desktopConf
      desktopHardware
      # Required
      nix-settings
      home-manager
      stateVersion
      bootLoader
      users
      shell
      rmtrash
      time-zone
      scx
      keyd
      # Declare that this nixos system uses unfree software
      unfree
      # Chaotic Required for
      #inputs.chaotic.nixosModules.default
      # CachyOS
      # self.nixosModules.cachyos
      # Optional Services
      syncthing
      tailscale
      ollama
      # self.nixosModules.ollama-cuda
      # Optional Programs
      browser
      anki
      fish
      direnv
      cosmic
      office
      gaming
      flatpak
      nix-dev
      devenv
    ];
  };
}
