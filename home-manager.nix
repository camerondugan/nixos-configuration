{
  pkgs,
  helix-flake,
  ...
}: let
  usr = "cam";
  # home-modules = ./home-modules;
  nix-modules = ./nix-modules;
  desktop-envs = nix-modules + "/desktop-environments";
  coding = nix-modules + "/coding";
  dot-config = nix-modules + "/dot-config";
  hyprlandFiles = desktop-envs + "/HyprlandFiles";
  helix = coding + "/helix";
in {
  imports = [
    ./home-modules/theme.nix
  ];
  home = {
    username = "cam";
    homeDirectory = "/home/cam";
    stateVersion = "23.05";
    sessionPath = [
      "/home/${usr}/go/bin/"
      "/home/${usr}/.cargo/bin/"
      "/home/${usr}/.go/bin/"
      "/home/${usr}/.go/current/bin/"
      "/home/${usr}/.system_node_modules/bin"
    ];
  };
  services.batsignal.enable = true;
  xdg = {
    configFile = {
      # Helix
      "helix/config.toml".source = helix + "/config.toml";
      "helix/languages.toml".source = helix + "/languages.toml";
      "helix/themes/transparent_bg.toml".source = helix + "/themes/transparent_bg.toml";

      # Zellij
      "zellij/config.kdl".source = dot-config + "/zellij/config.kdl";

      # Set Config File Locations
      "wezterm/wezterm.lua".source = coding + "/wezterm.lua";
      "ghostty/config".source = dot-config + "/ghostty.conf";
      "godot/text_editor_themes/godotTheme.tet".source = coding + "/godotTheme.tet";

      # Set Sirula Config
      "sirula/config.toml".source = dot-config + "/sirula-conf.toml";
      "sirula/style.css".source = dot-config + "/sirula-style.css";

      # Hyprland Config Files
      "hypr/hyprland.conf".source = hyprlandFiles + "/hyprland.conf";
      "hypr/hyprland.conf".onChange = "/run/current-system/sw/bin/hyprctl reload"; # useful for hyprland
      "hypr/hyprlock.conf".source = hyprlandFiles + "/hyprlock.conf";
      "hypr/hypridle.conf".source = hyprlandFiles + "/hypridle.conf";
      "wpaperd/config.toml".source = hyprlandFiles + "/wpaper.conf";
      "hypr/hyprpaper.conf".text =
        # conf
        ''
          preload = ~/.nixos/Assets/wallpaper.jpg
          wallpaper = ,~/.nixos/Assets/wallpaper.jpg
        '';

      "waybar/config".source = hyprlandFiles + "/waybar.conf";
      "waybar/config".onChange = "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";
      "waybar/style.css".source = hyprlandFiles + "/waybar.css";
      "waybar/style.css".onChange = "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";

      "wofi/style.css".source = hyprlandFiles + "/wofi.css";
      "wofi/config".source = hyprlandFiles + "/wofi.conf";
    };
  };

  programs = {
    helix = {
      enable = true;
      package = helix-flake.packages.${pkgs.system}.default;
    };

    git = {
      enable = true;
      userName = "Cameron Dugan";
      userEmail = "cameron.dugan@protonmail.com";
      lfs.enable = true;
      difftastic.enable = true;
      difftastic.enableAsDifftool = true;
      extraConfig = {
        core.editor = "hx";
        pull.rebase = false;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-webkitgtk
      ];
    };
  };
}
