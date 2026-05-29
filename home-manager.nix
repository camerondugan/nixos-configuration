{
  pkgs,
  inputs,
  # config,
  ...
}:
let
  usr = "cam";
  # home-modules = ./home-modules;
  nix-modules = ./nix-modules;
  desktop-envs = nix-modules + "/desktop-environments";
  # coding = nix-modules + "/coding";
  hyprlandFiles = desktop-envs + "/hypr";
in
{
  imports = [
    ./home-modules/theme.nix
  ];
  # specialisation = {
  #   dark.configuration = {
  #     theme.dark = lib.mkDefault true;
  #   };
  #   light.configuration = {
  #     theme.dark = lib.mkDefault false;
  #   };
  # };
  theme.dark = true;

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
    packages = with pkgs; [
      anki-bin
      blanket
      fd
    ];
  };
  # services.darkman = {
  #   enable = true;
  #   lightModeScripts = {
  #     light =
  #       # bash
  #       ''
  #         ${pkgs.home-manager}/bin/home-manager switch --flake /home/cam/.nixos -b backup
  #         $(${pkgs.home-manager}/bin/home-manager generations| ${pkgs.coreutils}/bin/head -1 | ${pkgs.gawk}/bin/awk '{print $7}')/specialisation/light/activate
  #         ${pkgs.toybox}/bin/pkill waybar
  #         ${pkgs.waybar}/bin/waybar &
  #       '';
  #   };
  #   darkModeScripts = {
  #     dark =
  #       # bash
  #       ''
  #         ${pkgs.home-manager}/bin/home-manager switch --flake /home/cam/.nixos -b backup
  #         $(${pkgs.home-manager}/bin/home-manager generations| ${pkgs.coreutils}/bin/head -1 | ${pkgs.gawk}/bin/awk '{print $7}')/specialisation/dark/activate
  #         ${pkgs.toybox}/bin/pkill waybar
  #         ${pkgs.waybar}/bin/waybar &
  #       '';
  #   };
  # };
  services.batsignal.enable = true;
  xdg = {
    configFile = {
      # "wezterm/wezterm.lua".source = coding + "/wezterm.lua";
      # "ghostty/config".source = dot-config + "/ghostty.conf";
      # "godot/text_editor_themes/godotTheme.tet".source = coding + "/godotTheme.tet";

      # note to future self, this is intentionally yml, not yaml
      "lazygit/config.yml".text =
        # yaml
        ''
          git:
            pagers:
              - externalDiffCommand: ${pkgs.difftastic}/bin/difft --display side-by-side
        '';

      # Set Sirula Config
      # "sirula/config.toml".source = dot-config + "/sirula-conf.toml";
      # "sirula/style.css".source = dot-config + "/sirula-style.css";

      # Zellij
      # "zellij/config.kdl".source = dot-config + "/zellij/config.kdl";

      # Hyprland Config Files
      # "hypr/hyprland.conf".source = hyprlandFiles + "/hyprland.conf";
      "hypr/hyprland.conf".onChange =
        "/run/current-system/sw/bin/hyprctl reload || echo 'Error occurred, is hyprland running?'"; # useful for hyprland
      "hypr/hyprlock.conf".source = hyprlandFiles + "/hyprlock.conf";
      # "hypr/hypridle.conf".source = hyprlandFiles + "/hypridle.conf";
      "wpaperd/config.toml".source = hyprlandFiles + "/wpaper.conf";
      # "hypr/hyprpaper.conf".text =
      #   # hyprlang
      #   ''
      #     preload = ~/.nixos/assets/wallpapers/topdownforest.jpg
      #     wallpaper = ,~/.nixos/assets/wallpapers/topdownforest.jpg
      #   '';

      # "waybar/config".source = hyprlandFiles + "/waybar.conf";
      # "waybar/config".onChange = "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";
      # "waybar/style.css".text =
      #   #css
      #   ''
      #      /* colors */
      #     @define-color panel #${config.lib.stylix.colors.base00};
      #     @define-color module-bg #${config.lib.stylix.colors.base01};
      #     @define-color bg #${config.lib.stylix.colors.base02};
      #     @define-color fg #${config.lib.stylix.colors.base05};
      #     @define-color button #${config.lib.stylix.colors.base04};
      #     @define-color hover #${config.lib.stylix.colors.base03};
      #     @define-color red #${config.lib.stylix.colors.base08};
      #     @define-color orange #${config.lib.stylix.colors.base09};
      #     @define-color yellow #${config.lib.stylix.colors.base0A};
      #     @define-color green #${config.lib.stylix.colors.base0B};
      #     @define-color cyan #${config.lib.stylix.colors.base0C};
      #     @define-color blue #${config.lib.stylix.colors.base0D};
      #     @define-color purple #${config.lib.stylix.colors.base0E};
      #     @define-color dark-red #${config.lib.stylix.colors.base0F};
      #     ${builtins.readFile (hyprlandFiles + "/waybar.css")}
      #   '';

      # "waybar/style.css".source = hyprlandFiles + "/waybar.css";
      # "waybar/style.css".onChange = "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";

      # "wofi/style.css".source = hyprlandFiles + "/wofi.css";
      # "wofi/config".source = hyprlandFiles + "/wofi.conf";
      "wlr-which-key/config.yaml".text = # yaml
        ''
          menu:
            - key: "U"
              desc: Unicode
              cmd: ${pkgs.ghostty}/bin/ghostty -e ${pkgs.unipicker}/bin/unipicker --copy-command ${pkgs.wl-clipboard-rs}/bin/wl-copy
            - key: "p"
              desc: Power
              submenu:
                - key: "s"
                  desc: Sleep
                  cmd: systemctl suspend
                - key: "r"
                  desc: Reboot
                  cmd: reboot
                - key: "o"
                  desc: Off
                  cmd: poweroff              
            - key: "l"
              desc: Learn
              submenu:
                - key: "a"
                  desc: Anki
                  cmd: ${pkgs.anki-bin}/bin/anki-bin
                - key: "d"
                  desc: Duolingo
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- --app=https://duolingo.com
            - key: "s"
              desc: Sound
              submenu:
                - key: "B"
                  desc: Blanket
                  cmd: ${pkgs.blanket}/bin/blanket
                - key: "m"
                  desc: Manage
                  cmd: ${pkgs.ghostty}/bin/ghostty -e pulsemixer
                - key: "b"
                  desc: Bluetooth
                  cmd: ${pkgs.ghostty}/bin/ghostty -e ${pkgs.bluetui}/bin/bluetui
            - key: "m"
              desc: Message
              submenu:
                - key: "w"
                  desc: Whatsapp
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- --app=https://web.whatsapp.com
                - key: "d"
                  desc: Discord
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- --app=https://discord.com/app
                - key: "g"
                  desc: Google Messages
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- --app=https://messages.google.com/web
            - key: "t"
              desc: Toggle
              submenu:
                - key: "l"
                  desc: Launcher
                  cmd: ${
                    inputs.caelestia-cli.packages.${pkgs.system}.default
                  }/bin/caelestia shell drawers toggle launcher
                - key: "t"
                  desc: Terminal
                  cmd: ${pkgs.ghostty}/bin/ghostty
                - key: "g"
                  desc: GameMode
                  cmd: ${
                    inputs.caelestia-cli.packages.${pkgs.system}.default
                  }/bin/caelestia shell gameMode toggle
            - key: "w"
              desc: Web
              submenu:
                - key: "b"
                  desc: Browser
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen
                - key: "n"
                  desc: NixOS
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- --app=https://search.nixos.org
                - key: "c"
                  desc: Calendar
                  cmd: ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- --app=https://calendar.google.com
              
        '';

      "hypr/hyprland.conf".text = # hypr
        ''
                  ################
          ### MONITORS ###
          ################

          # See https://wiki.hyprland.org/Configuring/Monitors/
          monitor=desc:BOE NE135A1M-NY1,preferred,auto,1.6
          monitor=DP-1,3440x1440@144,auto,1
          monitor=,preferred,auto,1

          ###################
          ### MY PROGRAMS ###
          ###################

          # See https://wiki.hyprland.org/Configuring/Keywords/

          # Set programs that you use
          $terminal = ${pkgs.ghostty}/bin/ghostty
          # $browser = ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen -- # firefox 
          $fileManager = ${pkgs.nautilus}/bin/nautilus
          # $dock = nwg-dock-hyprland
          # $dockArgs = -c $menu $menuArgs -lp 'start' -d -hd 80 

          #################
          ### AUTOSTART ###
          #################

          # Cache: Commonly used applications that start slowly
          exec-once = [workspace special:cache silent] $browser
          exec-once = ${pkgs.steam}/bin/steam -silent

          # Theming
          exec-once = ${pkgs.hyprland}/bin/hyprctl setcursor "Bibata-Modern-Ice" 24
          exec-once = ${pkgs.wpaperd}/bin/wpaperd -d

          # Hyprland Services
          # exec-once = nm-applet &
          # exec-once = blueman-applet &
          exec-once = ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator &
          # exec-once = waybar &
          # exec-once = swayosd-server &
          # exec-once = hyprnotify &
          # exec-once = hypridle &
          exec-once = ${pkgs.udiskie}/bin/udiskie &
          # exec-once = sunsetr
          exec-once = ${pkgs.systemd}/bin/systemctl --user start plasma-polkit-agent
          exec-once = caelestia-shell -d
          # exec-once = $dock $dockArgs

          exec-once = ${pkgs.coreutils}/bin/sleep 3 && ${pkgs.noisetorch}/bin/noisetorch -i &
          exec-once = ${pkgs.coreutils}/bin/sleep 3 && ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both &

          # Auto Start Apps
          exec-once = [workspace 2 silent] $terminal
          # exec-once = [workspace 3 silent] steam


          #############################
          ### ENVIRONMENT VARIABLES ###
          #############################

          # See https://wiki.hyprland.org/Configuring/Environment-variables/

          # # If you have Nvidia GPU
          # env = LIBVA_DRIVER_NAME,nvidia
          # env = GBM_BACKEND,nvidia-drm
          # env = __GLX_VENDOR_LIBRARY_NAME,nvidia # remove if firefox crashes
          # env = NVD_BACKEND,direct

          env = ELECTRON_OZONE_PLATFORM_HINT,auto

          # QT
          env = QT_QPA_PLATFORM,wayland
          env = QT_QPA_PLATFORMTHEME,qt5ct
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
          env = QT_AUTO_SCREEN_SCALE_FACTOR,1
          env = QT_STYLE_OVERRIDE,kvantum

          # Firefox
          env = MOZ_ENABLE_WAYLAND,1

          # Toolkit Backend Variables
          env = GDK_BACKEND,wayland,x11,*
          env = SDL_VIDEODRIVER,wayland
          env = CLUTTER_BACKEND,wayland

          # XDG Specifications
          env = XDG_CURRENT_DESKTOP,Hyprland
          env = XDG_SESSION_TYPE,wayland
          env = XDG_SESSION_DESKTOP,Hyprland
          env = XDG_SCREENSHOTS_DIR,/home/cam/Downloads

          #####################
          ### LOOK AND FEEL ###
          #####################

          general {
              gaps_in = 2
              gaps_out = 4

              border_size = 2

              col.active_border = rgb(b4befe) rgb(cba6f7) 45deg

              # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
              col.inactive_border = rgb(313244)

              # Set to true enable resizing windows by clicking and dragging on borders and gaps
              resize_on_border = true

              layout = dwindle
          }

          layout {
              single_window_aspect_ratio = 4 3
          }

          decoration {
              rounding = 15
              blur {
                  enabled = true
                  passes = 2
              }
              dim_inactive = true
              dim_strength = 0.05
              # inactive_opacity = 0.9
              shadow {
                  enabled = true
                  range = 64
                  color = rgba(00000080)
              }
          }


          # https://wiki.hyprland.org/Configuring/Variables/#animations
          animations {
              enabled = true

              # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              # bezier = myBezier, 0.05, 0.9, 0.1, 1.05

              animation = windows, 1, 4, default, popin
              # animation = windowsOut, 1, 10, default, slide
              animation = border, 1, 4, default
              # animation = borderangle, 1, 10, default
              animation = fade, 1, 4, default
              animation = workspaces, 1, 4, default, slidefade
          }

          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          dwindle {
              pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true # You probably want this
              split_width_multiplier = 0.7
          }

          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          master {
              new_status = master
          }

          group {
              col.border_active = rgb(a6e3a1) rgb(fab387) 45deg
              col.border_inactive = rgb(a6e3a1) rgb(fab387) 45deg
              groupbar {
                  render_titles = false
                  height = 0
                  col.active = rgb(a6e3a1)
                  # col.active = rgb(45475a)
                  col.inactive = rgb(1e1e2e)
                  text_color = rgb(cdd6f4)
              }
          }

          # https://wiki.hyprland.org/Configuring/Variables/#misc
          misc {
              vfr = true
              force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
              disable_hyprland_logo = true # If true disables the anime girl

              mouse_move_enables_dpms = true
              key_press_enables_dpms = true
          }

          #############
          ### INPUT ###
          #############

          # https://wiki.hyprland.org/Configuring/Variables/#input
          input {
              kb_layout = us
              kb_variant =
              kb_model =
              kb_options =
              kb_rules =
              numlock_by_default = true

              follow_mouse = 1

              sensitivity = 0 # modification normalized

              touchpad {
                  natural_scroll = true
                  scroll_factor = 0.3
              }
          }

          # Example per-device config
          # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more

          # Trackball
          device {
              name = logitech-ergo-m575
              sensitivity = 1.0
          }

          # Framework13 trackpad
          device {
             name = pixa3854:00-093a:0274-touchpad
             sensitivity = 0.3
          }

          xwayland {
              force_zero_scaling = true
          }

          ####################
          ### KEYBINDINGSS ###
          ####################

          # See https://wiki.hyprland.org/Configuring/Keywords/
          $mainMod = SUPER # Sets "Windows" key as main modifier
          $shiftMod= SUPER_SHIFT # Sets Shift + "Windows" key as a secondary modifier

          # see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = $mainMod, T, exec, $terminal
          # bind = $mainMod, W, exec, $browser
          bind = $mainMod, W, exec, ${pkgs.flatpak}/bin/flatpak run app.zen_browser.zen
          # bind = $mainMod ALT, M, exec, $browser --app=https://meet.google.com/landing?calling=1
          bind = $mainMod, S, exec, ${pkgs.steam}/bin/steam
          bind = $mainMod, Q, killactive
          bind = $mainMod, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t #notifications
          # bind = $mainMod ALT, N, exec, $browser --app=https://netflix.com
          bind = $mainMod SHIFT, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client --close-all
          bind = $mainMod CONTROL, Q, exec, ${
            inputs.caelestia-cli.packages.${pkgs.system}.default
          }/bin/caelestia shell lock lock
          bind = $shiftMod, G, exec, ${
            inputs.caelestia-cli.packages.${pkgs.system}.default
          }/bin/caelestia shell gameMode toggle
          bind = $shiftMod CONTROL, Q, exec, ${pkgs.systemd}/bin/poweroff
          bind = $mainMod, E, exec, pkill $fileManager || $fileManager
          bind = $mainMod, O, togglefloating
          bind = $mainMod, F, fullscreen
          bind = $mainMod, Super_L, exec, ${pkgs.wlr-which-key}/bin/wlr-which-key
          bind = $shiftMod, Super_L, exec, ${
            inputs.caelestia-cli.packages.${pkgs.system}.default
          }/bin/caelestia shell drawers toggle launcher
          bind = $mainMod, U, pseudo, # dwindle
          bind = $mainMod, R, togglesplit, # dwindle
          bind = $mainMod, I, pin # toggle pinned window
          bind = $mainMod, P, exec, ${
            inputs.caelestia-cli.packages.${pkgs.system}.default
          }/bin/caelestia shell picker open # window screenshot
          bind = $mainMod ALT, P, exec, ${pkgs.wl-color-picker}/bin/wl-color-picker # color picker
          bind = $mainMod SHIFT, B, exec, ${pkgs.toybox}/bin/pkill waybar || ${pkgs.waybar}/bin/waybar
          bind = $mainMod, B, exec, ${pkgs.ghostty}/bin/ghostty -e ${pkgs.bluetui}/bin/bluetui
          bind = $mainMod, M, exec, ${pkgs.ghostty}/bin/ghostty -e pulsemixer # TODO: flake input?
          bind = $shiftMod, U, exec, ${pkgs.ghostty}/bin/ghostty -e ${pkgs.unipicker}/bin/unipicker --copy-command ${pkgs.wl-clipboard-rs}/bin/wl-copy

          # to switch between windows in a floating workspace
          bind = SUPER, Tab, cyclenext, prev         # change focus to another window
          bind = SUPER, Tab, bringactivetotop,       # bring it to the top
          bind = $shiftMod, Tab, cyclenext         # change focus to a previous window
          bind = $shiftMod, Tab, bringactivetotop, # bring it to the top

          # Move focus with mainMod + arrow keys
          bind = $mainMod, H, movefocus, l
          bind = $mainMod, L, movefocus, r
          bind = $mainMod, K, movefocus, u
          bind = $mainMod, J, movefocus, d

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          # Move windows with mainMod + arrow keys
          bind = $mainMod CTRL, H, movewindoworgroup, l
          bind = $mainMod CTRL, L, movewindoworgroup, r
          bind = $mainMod CTRL, K, movewindoworgroup, u
          bind = $mainMod CTRL, J, movewindoworgroup, d

          # Move windows with mainMod + arrow keys
          bind = $mainMod CTRL, left, movewindoworgroup, l
          bind = $mainMod CTRL, right, movewindoworgroup, r
          bind = $mainMod CTRL, up, movewindoworgroup, u
          bind = $mainMod CTRL, down, movewindoworgroup, d

          # Move workspaces
          bind = $mainMod SHIFT, H, workspace, -1
          bind = $mainMod SHIFT, L, workspace, +1

          # Move workspaces
          bind = $mainMod SHIFT, left, workspace, -1
          bind = $mainMod SHIFT, right, workspace, +1

          # Move windows to workspaces
          bind = $mainMod ALT, H, movetoworkspace, -1
          bind = $mainMod ALT, L, movetoworkspace, +1
          bind = $mainMod SHIFT CTRL, H, movetoworkspace, -1
          bind = $mainMod SHIFT CTRL, L, movetoworkspace, +1
          bind = $mainMod SHIFT ALT, H, movetoworkspacesilent, -1
          bind = $mainMod SHIFT ALT, L, movetoworkspacesilent, +1

          # Move windows to workspaces
          bind = $mainMod ALT, right, movetoworkspace, +1
          bind = $mainMod ALT, left, movetoworkspace, -1
          bind = $mainMod SHIFT ALT, right, movetoworkspacesilent, +1
          bind = $mainMod SHIFT ALT, left, movetoworkspacesilent, -1

          # Groups
          bind = $mainMod, G, togglegroup
          bind = $mainMod ALT, O, changegroupactive, f
          bind = $mainMod ALT, I, changegroupactive, b
          bind = ALT, Tab, changegroupactive, f
          bind = ALT Shift, Tab, changegroupactive, b

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # same as above, but without changing current workspace
          bind = $mainMod ALT, 1, movetoworkspacesilent, 1
          bind = $mainMod ALT, 2, movetoworkspacesilent, 2
          bind = $mainMod ALT, 3, movetoworkspacesilent, 3
          bind = $mainMod ALT, 4, movetoworkspacesilent, 4
          bind = $mainMod ALT, 5, movetoworkspacesilent, 5
          bind = $mainMod ALT, 6, movetoworkspacesilent, 6
          bind = $mainMod ALT, 7, movetoworkspacesilent, 7
          bind = $mainMod ALT, 8, movetoworkspacesilent, 8
          bind = $mainMod ALT, 9, movetoworkspacesilent, 9
          bind = $mainMod ALT, 0, movetoworkspacesilent, 10

          # bind = $mainMod ALT, d, exec, darkman toggle

          # Example special workspace (scratchpad)
          bind = $mainMod,       Y, togglespecialworkspace, magic
          # bind = $mainMod ALT, Y, exec, $browser --app=https://youtube.com
          bind = $mainMod SHIFT, Y, movetoworkspace,        special:magic
          bind = $mainMod,   escape, movetoworkspace,        +0
          bind = $mainMod ALT,   Y, movetoworkspace,        +0
          bind = $mainMod CTRL,   Y, movetoworkspace,        +0

          # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow
          bindm = $mainMod SHIFT, mouse:273, resizewindow 1

          # Picture in Picture Toggle for any window
          bind = $mainMod CTRL, P, togglefloating
          bind = $mainMod CTRL, P, pin
          bind = $mainMod CTRL, P, resizeactive, exact 640 360
          bind = $mainMod CTRL, P, fullscreenstate, 0 2
          bind = $mainMod CTRL, P, movewindow, r
          bind = $mainMod CTRL, P, movewindow, d
          # bind = $mainMod CTRL, P, exec, hyprctl dispatch moveactiveonscreen 100% 100%
          # bind = $mainMod CTRL, P, nodim
          # bind = $mainMod CTRL, P, keepaspectratio

          # Volume and Media Control
           
          ## With on screen indicator
          # # Volume
          # binde = , XF86AudioRaiseVolume, exec, swayosdswayosd-client --brightness raise-client --output-volume raise
          # binde = , XF86AudioLowerVolume, exec, swayosd-client --output-volume lower
          # bind = , XF86AudioMute, exec, swayosd-client --output-volume mute-toggle
          # bind = , XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle
           
          # # Caps Lock
          # bindr = CAPS, Caps_Lock, exec, swayosd-client --caps-lock

          # # Screen brightness
          # binde = , XF86MonBrightnessUp, exec, swayosd-client --brightness raise
          # binde = , XF86MonBrightnessDown, exec, swayosd-client --brightness lower

          ## Without on screen indicator
          # Volume
          binde = , XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          binde = , XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bind = , XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bind = , XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

          # Play pause
          bind = , XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause
          bind = , XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause
          bind = , XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next
          bind = , XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous

          # Screen brightness
          binde = , XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%
          binde = , XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-

          ##############################
          ### WINDOWS AND WORKSPACES ###
          ##############################

          # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
          # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

          # Example windowrule v1
          # windowrule = float, ^(kitty)$

          # Example windowrule v2
          # windowrule = float on,class:^(kitty)$,title:^(kitty)$
          windowrule = suppress_event maximize, match:class ^(.*)$
          windowrule = float on, match:initial_title ^(Open Files)$

          # Things not defined probably float on
          windowrule = float on, match:initial_class ^()$,match:initial_title ^()$
          # windowrule = no_initial_focus on,match:initial_class ^()$,match:initial_title ^()$

          # Bluetooth and audio menu positioning and sizing
          windowrule = float on,match:initial_class ^(.blueman-applet-wrapped|.blueman-manager-wrapped|org.pulseaudio.pavucontrol)$
          # windowrule = size 350 110,match:initial_class ^(.blueman-applet-wrapped|.blueman-manager-wrapped|org.pulseaudio.pavucontrol)$
          windowrule = move monitor_w-window_w-5 35,match:initial_class ^(.blueman-applet-wrapped|.blueman-manager-wrapped|org.pulseaudio.pavucontrol)$
          # windowrule = no_initial_focus on,match:initial_class ^(.blueman-applet-wrapped|.blueman-manager-wrapped|org.pulseaudio.pavucontrol)$

          # Make browser less useful and more beautiful to encourage setting up hotkeys to key websites
          windowrule = fullscreen_state 0 2,match:initial_class (chrome-.*-Default)
          # windowrule = fullscreenstate 0 2,class:(google-chrome)

          # # Firefox Notifications Positioning and Sizing
          # windowrule = float on,match:initial_class ^(firefox)$,match:initial_title ^()$
          # windowrule = size 350 110,match:initial_class ^(firefox)$,match:initial_title ^()$
          # windowrule = move onscreen 100% 0%,match:initial_class ^(firefox)$,match:initial_title ^()$
          # windowrule = no_initial_focus on,match:initial_class ^(firefox)$,match:initial_title ^()$

          # Chrome notifications for some reason
          windowrule = move monitor_w-window_w monitor_h-window_h,match:initial_class ^()$,match:initial_title ^()$
          windowrule = no_initial_focus on,match:initial_class ^()$,match:initial_title ^()$

          # XDG File Picker
          windowrule = float on,match:initial_title ^(Open File)$
          windowrule = move (cursor_x-0.5*window_w) (cursor_y-0.25*window_h),match:initial_title ^(Open File)$
          windowrule = no_initial_focus on,match:initial_title ^(Open File)$

          # File Picker
          windowrule = float on,match:initial_class ^(xdg-desktop-portal-gtk|org.gnome.Nautilus)$
          windowrule = move onscreen cursor (cursor_x-0.5*window_w) (cursor_y-.25*window_h),match:initial_class ^(xdg-desktop-portal-gtk|org.gnome.Nautilus)$
          # windowrule = no_initial_focus on,match:initial_class ^(xdg-desktop-portal-gtk|org.gnome.Nautilus)$
          windowrule = persistent_size on, match:initial_class ^(xdg-desktop-portal-gtk|org.gnome.Nautilus)$

          # Bitwarden
          windowrule = float on,match:initial_title ^(Bitwarden)$

          # Anki
          windowrule = float on,match:initial_class ^(Anki)$
          windowrule = center on,match:title ^(User .* - Anki)$

          # Unipicker
          windowrule = float on,match:title ^(unipicker)$

          # File manager
          # windowrule = float on, match:initial_class ^(org.gnome.Nautilus)$
          # windowrule = center on, match:initial_class ^(org.gnome.Nautilus)$
          # windowrule = size {"(monitor_w*0.3)", "(monitor_h*0.3)"}, ^(org.gnome.Nautilus)$

        '';
    };
  };

  programs = {
    helix = {
      enable = true;
      package = inputs.helix.packages.${pkgs.system}.default;
      settings = {
        # theme = if config.theme.dark then "doom-one" else "flatwhite";
        theme = "base16_default";
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
          };
          rulers = [
            120
            80
          ];
          bufferline = "multiple";
          lsp = {
            goto-reference-include-declaration = false;
            display-progress-messages = true;
            display-inlay-hints = true;
          };
          # end-of-line-diagnostics = "hint";
          # inline-diagnostics = {
          #   cursor-line = "warning";
          # };
          # indent-guides = {
          #   render = true;
          # };
          popup-border = "all";
          auto-format = true;
          auto-save = {
            focus-lost = true;
            after-delay.enable = true;
          };
        };
        keys.normal = {
          ret = [ "goto_word" ];
          X = [ "extend_line_above" ];
          C-j = [
            "extend_to_line_bounds"
            "delete_selection"
            "paste_after"
            "goto_line_start"
          ];
          C-k = [
            "extend_to_line_bounds"
            "delete_selection"
            "move_line_up"
            "paste_before"
            "goto_line_start"
          ];
          "A-D" = "@mdm";
          "A-q" = "@ms\"";
          "A-[" = "@ms]";
          "A-]" = "@ms]";
          "A-0" = "@ms(";
          "A-9" = "@ms)";
          "A-{" = "@ms{";
          "M" = "@mam";
        };
        keys.normal.space = {
          # ret = [ "goto_word" ];
          W = ":update";
          B = ":echo %sh{git blame -L %{cursor_line},+1 %{buffer_name}}";
          m = ":sh zellij run -d right -- make";
          j = ":sh zellij run -d right -- just"; # overrides jump search
          n = ":sh zellij run -d right -- nix build";
          l = ":sh zellij run -i -c -- lazygit";
        };
        # Toggle
        keys.normal.space.t = {
          i = ":toggle lsp.display-inlay-hints";
          s = ":toggle soft-wrap.enable";
          w = ":toggle soft-wrap.wrap-at-text-width";
          g = ":toggle indent-guides.render";
          h = ":toggle file-picker.git-ignore";
          f = ":toggle auto-format";
          o = ":toggle auto-info";
          b = ":toggle bufferline never multiple";
          l = ":toggle line-number relative absolute";
        };
        keys.normal.Z = {
          Z = [ "wclose" ]; # Could not use write_quit since it doesn't exist :(
        };
      };
      languages = {
        global-language-servers = [
          "harper-ls"
        ];
        language = [
          {
            name = "markdown";
            language-servers = [
              "marksman"
              "markdown-oxide"
              "harper-ls"
            ];
            formatter = {
              command = "${pkgs.dprint}/bin/dprint";
              args = [
                "fmt"
                "--stdin"
                "md"
              ];
            };
            soft-wrap = {
              enable = true;
              wrap-at-text-width = true;
            };
          }
          {
            name = "rust";
            language-servers = [
              "rust-analyzer"
              # "..."
              "harper-ls"
            ];
            # ignore-global-language-servers = true;
          }
          {
            name = "bash";
            language-servers = [
              "bash-language-server"
              "harper-ls"
            ];
          }
          {
            name = "nix";
            language-servers = [
              "nil"
              "nixd"
              "harper-ls"
            ];
            auto-format = true;
          }
          {
            name = "go";
            language-servers = [
              "gopls"
              "golangci-lint-langserver"
              "harper-ls"
            ];
          }
          {
            name = "zig";
            language-servers = [
              "zls"
              "harper-ls"
            ];
          }
          {
            name = "gdscript";
            file-types = [ "gd" ];
            language-servers = [
              "gdscript"
              "harper-ls"
            ];
          }
        ];

        language-server = {
          harper-ls = {
            command = "${pkgs.harper}/bin/harper-ls";
            args = [ "--stdio" ];
          };
          gdscript = {
            language-id = "gdscript";
            command = "${pkgs.netcat}/bin/nc";
            args = [
              "127.0.0.1"
              "6005"
            ];
          };
        };
      };
    };

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-size = 18;
        font-family = "JetBrainsMono Nerd Font Mono";
        theme = "light:Selenized Light,dark:Selenized Black";
        # theme = "stylix";
        keybind = "ctrl+;=toggle_quick_terminal";
        # background-opacity=0.85;
        background-blur = true;
        confirm-close-surface = false;
      };
    };

    zellij = {
      enable = true;
    };

    ssh = {
      matchBlocks = {
        "*" = {
          identityFile = [ "~/.ssh/id_ed25519" ];
        };
      };
    };

    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "Cameron Dugan";
        user.email = "me@camerondugan.com";
      };
      signing.format = null;
      ## Desktop only setup rn
      # signing.key = "5A39B85F7BEE2BB880AF0F72A6E4FD72C9C868ED";
      # extraConfig.commit.gpgsign = true;
      # editor = "hx";
      # settings = {
      # user.name = "Cameron Dugan";
      # user.email = "cameron.dugan@protonmail.com";
      # core.editor = "hx";
      # pull.rebase = true;
      # };
    };

    difftastic = {
      enable = true;
      git.enable = true;
      git.diffToolMode = true;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        # obs-webkitgtk
      ];
    };

    ## Makes Hyprland a Desktop Environment
    caelestia = {
      enable = false;
      cli = {
        enable = false;
      };
      settings = {
        border.rounding = 15;
        border.thickness = 1;
        paths.sessionGif = "~/.nixos/assets/waddle.gif";
        paths.wallpaperDir = "~/.nixos/assets/wallpapers/";
        launcher.showOnHover = true;
        bar.status.showAudio = true;
        # bar.status.showMicrophone = true;
        bar.tray.recolour = true;
        general.idle.lockBeforeSleep = true;
        general.idle.inhibitWhenAudio = true;
        general.idle.timeouts = [
          {
            timeout = 180;
            idleAction = "lock";
          }
          {
            timeout = 300;
            idleAction = "dpms off";
            returnAction = "dpms on";
          }
          # {
          #   timeout = 600;
          #   idleAction = ["systemctl" "suspend-then-hibernate"];
          # }
          {
            # Handles cases where suspend-then-hibernate doesn't work
            # Haven't tested yet on systems where suspend-then-hibernate does work
            # Assumption: system will be paused and time-out below won't be hit on resume
            timeout = 610;
            idleAction = [
              "systemctl"
              "poweroff"
            ];
          }
        ];
      };
    };
  };
}
