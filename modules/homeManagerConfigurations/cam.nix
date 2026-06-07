{ inputs, ... }:
{
  flake.homeConfigurations.cam = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };
    modules = [
      inputs.self.homeModules.editor
      inputs.self.homeModules.neovim
      inputs.self.homeModules.ghostty
      inputs.self.homeModules.zellij
      inputs.self.homeModules.git
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
