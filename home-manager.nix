{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  usr = "cam";
  # home-modules = ./home-modules;
  nix-modules = ./nix-modules;
  desktop-envs = nix-modules + "/desktop-environments";
  coding = nix-modules + "/coding";
  dot-config = nix-modules + "/dot-config";
  hyprlandFiles = desktop-envs + "/HyprlandFiles";
in {
  imports = [
    ./home-modules/theme.nix
  ];
  specialisation = {
    dark.configuration = {
      theme.dark = lib.mkDefault true;
    };
    light.configuration = {
      theme.dark = lib.mkDefault false;
    };
  };

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
  services.darkman = {
    enable = true;
    lightModeScripts = {
      light = # bash
      ''
        ${pkgs.home-manager}/bin/home-manager switch --flake /home/cam/.nixos -b backup
        $(${pkgs.home-manager}/bin/home-manager generations| ${pkgs.coreutils}/bin/head -1 | awk '{print $7}')/specialisation/light/activate
        pkill waybar
        ${pkgs.waybar}/bin/waybar &
      '';
    };
    darkModeScripts = {
      dark = # bash
      ''
        ${pkgs.home-manager}/bin/home-manager switch --flake /home/cam/.nixos -b backup
        $(${pkgs.home-manager}/bin/home-manager generations| ${pkgs.coreutils}/bin/head -1 | awk '{print $7}')/specialisation/dark/activate
        pkill waybar
        ${pkgs.waybar}/bin/waybar &
      '';
    };
  };
  services.batsignal.enable = true;
  xdg = {
    configFile = {
      # Helix
      "helix/config.toml".text = # toml
       ''
        theme = "transparent_bg"

        [keys.normal.space.t]
        "l"= ":theme solarized_light"
        "d"= ":theme solarized_dark"

        [editor]
        line-number = "relative"

        [editor.cursor-shape]
        insert = "bar"
      '';
      "helix/languages.toml".text = # toml
      ''
        [[language]]
        name = "gdscript"
        file-types = ["gd"]
        language-servers = ["gdscript"]

        [language-server.gdscript]
        command = "nc"
        args = [ "127.0.0.1", "6005" ] 
        language-id = "gdscript"
      '';
      "helix/themes/transparent_bg.toml".text = # toml
      ''
        inherits = "${if config.theme.dark then "solarized_dark" else "solarized_light"}"
        "ui.background" = {}
      '';

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
      "waybar/style.css".text = #css
      ''
         /* colors */
        @define-color panel #${config.lib.stylix.colors.base00};
        @define-color module-bg #${config.lib.stylix.colors.base01};
        @define-color bg #${config.lib.stylix.colors.base02};
        @define-color fg #${config.lib.stylix.colors.base05};
        @define-color button #${config.lib.stylix.colors.base04};
        @define-color hover #${config.lib.stylix.colors.base03};
        @define-color red #${config.lib.stylix.colors.base08};
        @define-color orange #${config.lib.stylix.colors.base09};
        @define-color yellow #${config.lib.stylix.colors.base0A};
        @define-color green #${config.lib.stylix.colors.base0B};
        @define-color cyan #${config.lib.stylix.colors.base0C};
        @define-color blue #${config.lib.stylix.colors.base0D};
        @define-color purple #${config.lib.stylix.colors.base0E};
        @define-color dark-red #${config.lib.stylix.colors.base0F};
        ${builtins.readFile (hyprlandFiles + "/waybar.css")}
      '';
      # "waybar/style.css".source = hyprlandFiles + "/waybar.css";
      # "waybar/style.css".onChange = "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";

      # "wofi/style.css".source = hyprlandFiles + "/wofi.css";
      # "wofi/config".source = hyprlandFiles + "/wofi.conf";
    };
  };

  programs = {
    helix = {
      enable = true;
      package = inputs.helix.packages.${pkgs.system}.default;
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
