{pkgs, helix-flake, ...}: let
  usr = "cam";
in {
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
  xdg = {
    configFile = {
      # Helix
      "helix/config.toml".source = ./Software/CoderFiles/helix/config.toml;
      "helix/languages.toml".source = ./Software/CoderFiles/helix/languages.toml;

      # Set Config File Locations
      "wezterm/wezterm.lua".source =
        ./Software/CoderFiles/wezterm.lua;
      "ghostty/config".source = ./SoftwareConfig/ghostty.conf;
      "godot/text_editor_themes/godotTheme.tet".source =
        ./Software/CoderFiles/godotTheme.tet;

      # Set Sirula Config
      "sirula/config.toml".source = ./SoftwareConfig/sirula-conf.toml;
      "sirula/style.css".source = ./SoftwareConfig/sirula-style.css;

      # Hyprland Config Files
      "hypr/hyprland.conf".source = ./DesktopEnvironments/HyprlandFiles/hyprland.conf;
      "hypr/hyprland.conf".onChange = "/run/current-system/sw/bin/hyprctl reload"; # useful for hyprland
      "hypr/hyprlock.conf".source = ./DesktopEnvironments/HyprlandFiles/hyprlock.conf;
      "hypr/hypridle.conf".source = ./DesktopEnvironments/HyprlandFiles/hypridle.conf;
      "wpaperd/config.toml".source = ./DesktopEnvironments/HyprlandFiles/wpaper.conf;
      "hypr/hyprpaper.conf".text = ''
        preload = ~/.nixos/Assets/wallpaper.jpg
        wallpaper = ,~/.nixos/Assets/wallpaper.jpg
      '';

      "waybar/config".source = ./DesktopEnvironments/HyprlandFiles/waybar.conf;
      "waybar/config".onChange= "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";
      "waybar/style.css".source = ./DesktopEnvironments/HyprlandFiles/waybar.css;
      "waybar/style.css".onChange= "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";

      "wofi/style.css".source = ./DesktopEnvironments/HyprlandFiles/wofi.css;
      "wofi/config".source = ./DesktopEnvironments/HyprlandFiles/wofi.conf; 
    };
  };

  # Set Cursor Theme
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
    size = 24;
  };

  # Theme Setup
  # Set GTK App Theme
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
      clock-format = "12h";
      clock-show-weekday = true;
      clock-show-date = true;
      clock-show-seconds = false;
      # gtk-theme = "Adwaita-dark";
      font-hinting = "medium";
      font-antialiasing = "grayscale";
    };
    "org/gnome/desktop/sound" = {
      event-sounds = "false";
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };
    "org/gnome/desktop/privacy" = {
      remove-old-trash-files = true;
      remove-old-temp-files = true;
    };
    "org/gnome/desktop/media-handling" = {
      # Ask what to do instead of auto running software from USB
      autorun-x-content-start-app = ["x-content/ostree-repository"];
      autorun-never = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        #make caps ctrl
        "terminate:ctr_alt_bksp"
        "lv3:ralt_switch"
        "caps:ctrl_modifier"
      ];
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "mouse"; #sloppy, mouse, click
      auto-raise = false;
      button-layout = "appmenu:minimize,maximize,close";
      resize-with-right-button = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      minimize = []; #["<Super>j"];
      close = ["<Super>q"];
      # Disabled because pop-shell
      switch-to-workspace-left = ["<Alt><Super>h"];
      switch-to-workspace-right = ["<Alt><Super>l"];
      move-to-workspace-left = ["<Control><Super>h"];
      move-to-workspace-right = ["<Control><Super>l"];
      toggle-fullscreen = ["<Super>f"];
      # toggle-on-all-workspaces = ["<Super>p"];
      toggle-message-tray = ["<Super>v"];
      show-desktop = ["<Super>d"];
    };
    "org/gnome/Console" = {
      use-system-font = false;
      custom-font = "JetBrainsMono Nerd Font Mono 12";
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = false;
      attach-modal-dialogs = false;
      center-new-windows = false;
      resize-with-right-button = true;
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "hibernate";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      www = ["<Super>b"];
      search = ["<Super>r"];
      #calculator = ["<Super>m"]; #m = math
      logout = ["<Super><Shift>m"];
      screensaver = "unset";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "kgx";
      name = "Launch Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>n";
      command = "neovide --multigrid --size 1500x1375";
      name = "Launch nvim GUI";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>e";
      command = "nautilus";
      name = "Launch File Explorer";
    };
    "org/gnome/shell/keybindings" = {
      focus-active-notification = ["<Shift><Super>n"];
    };
    "org/gnome/shell" = {
      favorite-apps = ["firefox.desktop" "neovide.desktop" "anki.desktop" "org.gnome.Console.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Music.desktop" "gnome-system-monitor.desktop"];
      enabled-extensions = ["espresso@coadmunkee.github.com" "rounded-window-corners@yilozt" "Rounded_Corners@lennart-k" "pop-shell@system76.com" "pip-on-top@rafostar.github.com" "trayIconsReloaded@selfmade.pl" "drive-menu@gnome-shell-extensions.gcampax.github.com" "dash-to-dock@micxgx.gmail.com" "blur-my-shell@aunetx"];
      disabled-extensions = [];
    };
    "org/gnome/shell/extensions/espresso" = {
      show-indicator = false;
      show-notifications = false;
    };
    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = true;
      show-title = false;
      smart-gaps = true;
      stacking-with-mouse = false;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Set QT Theme
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
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

    thefuck = {
        enable = true;
        enableFishIntegration = true;
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
