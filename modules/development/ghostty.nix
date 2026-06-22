{
  flake.homeModules.ghostty = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-size = 16;
        font-family = "JetBrainsMono Nerd Font Mono";
        # theme = "light:Selenized Light,dark:Selenized Black";
        # theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
        theme = "light:Zenbones Light,dark:Zenbones Dark";
        # theme = "stylix";
        keybind = "ctrl+;=toggle_quick_terminal";
        # background-opacity=0.85;
        background-blur = true;
        confirm-close-surface = false;
      };
    };
  };
}
