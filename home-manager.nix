{
  pkgs,
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
  hyprlandFiles = desktop-envs + "/hypr";
in {
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
      "wezterm/wezterm.lua".source = coding + "/wezterm.lua";
      # "ghostty/config".source = dot-config + "/ghostty.conf";
      "godot/text_editor_themes/godotTheme.tet".source = coding + "/godotTheme.tet";

      # note to future self, this is intentionally yml, not yaml
      "lazygit/config.yml".text = #yaml
      ''
        git:
          paging:
            externalDiffCommand: ${pkgs.difftastic}/bin/difft --display side-by-side
      '';

      # Set Sirula Config
      "sirula/config.toml".source = dot-config + "/sirula-conf.toml";
      "sirula/style.css".source = dot-config + "/sirula-style.css";

      # Zellij
      "zellij/config.kdl".source = dot-config + "/zellij/config.kdl";

      # Hyprland Config Files
      "hypr/hyprland.conf".source = hyprlandFiles + "/hyprland.conf";
      "hypr/hyprland.conf".onChange = "/run/current-system/sw/bin/hyprctl reload || echo 'Error occurred, is hyprland running?'"; # useful for hyprland
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
      "waybar/style.css".text =
        #css
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
      settings = {
        theme =
          if config.theme.dark
          then "onedarker"
          else "zed_onelight";
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
          };
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
        };
      };
      languages = {
        language = [
          {
            name = "markdown";
            language-servers = ["marksman" "markdown-oxide" "codebook"];
          }
          {
            name = "rust";
            language-servers = ["rust-analyzer" "codebook"];
          }
          {
            name = "bash";
            language-servers = ["bash-language-server" "codebook"];
          }
          {
            name = "nix";
            language-servers = ["nil" "nixd" "codebook"];
          }
          {
            name = "gdscript";
            file-types = ["gd"];
            language-servers = ["gdscript" "codebook"];
          }
        ];

        language-server = {
          codebook = {
            command = "${pkgs.codebook}/bin/codebook-lsp";
            args = ["serve"];
          };
          gdscript = {
            language-id = "gdscript";
            command = "${pkgs.netcat}/bin/nc";
            args = ["127.0.0.1" "6005"];
          };
        };
      };
    };

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-size = 12;
        font-family = "JetBrainsMono Nerd Font Mono";
        # theme="light:Builtin Solarized Light,dark:Builtin Solarized Dark";
        theme = "stylix";
        keybind = "ctrl+;=toggle_quick_terminal";
        # background-opacity=0.85;
        background-blur = true;
        confirm-close-surface = false;
      };
    };

    zellij = {
      enable = true;
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
        pull.rebase = true;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        # obs-webkitgtk
      ];
    };
  };
}
