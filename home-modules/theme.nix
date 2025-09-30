{
  pkgs,
  lib,
  config,
  ...
}: {
  options.theme = {
    dark = lib.mkEnableOption "enables dark mode";
    terminalPrompt.enable = lib.mkEnableOption "enhanced terminal prompt";
  };

  config = {
    stylix.enable = true;
    stylix.polarity =
      if config.theme.dark
      then "dark"
      else "light";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest${ if config.theme.dark then "-dark-hard" else "" }.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-${
    #   if config.theme.dark
    #   then "dark-hard"
    #   else "light-hard"
    # }.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/one${ if config.theme.dark then "dark" else "-light" }.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-${ if config.theme.dark then "dark" else "light" }.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/selenized-${ if config.theme.dark then "dark" else "white" }.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/github${ if config.theme.dark then "-dark" else "" }.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/chinoiserie.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${ if config.theme.dark then "onedark" else "nord-light" }.yaml";
    stylix.image = ../assets/FW12_Wallpaper_Sage.png;
    stylix.autoEnable = true;
    stylix.opacity.terminal = 0.9;

    stylix.targets.waybar.enable = false;
    stylix.targets.helix.enable = false;

    stylix.iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      light = "Adwaita";
      dark = "Adwaita";
    };

    # Set Cursor Theme
    home.pointerCursor = {
      name =
        if config.theme.dark
        then "Bibata-Modern-Ice"
        else "Bibata-Moden-Classic";
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
  };
}
