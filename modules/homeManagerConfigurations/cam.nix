{inputs, ...}: {
  flake.homeConfigurations.cam = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };
    modules = with inputs.self.homeModules; [
      helix
      neovim
      ghostty
      zellij
      git
      super-prod
      {
        home = {
          username = "cam";
          homeDirectory = "/home/cam";
          stateVersion = "23.05";
          # sessionPath = [
          #   "/home/cam/go/bin/"
          #   "/home/cam/.cargo/bin/"
          #   "/home/cam/.go/bin/"
          #   "/home/cam/.go/current/bin/"
          #   "/home/cam/.system_node_modules/bin"
          # ];
        };
      }
    ];
  };
}
