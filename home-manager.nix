{
  pkgs,
  inputs,
  config,
  ...
}:
let
  usr = "cam";
  # home-modules = ./home-modules;
  nix-modules = ./nix-modules;
  desktop-envs = nix-modules + "/desktop-environments";
  coding = nix-modules + "/coding";
  dot-config = nix-modules + "/dot-config";
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
      "lazygit/config.yml".text = # yaml
        ''
          git:
            paging:
              externalDiffCommand: ${pkgs.difftastic}/bin/difft --display side-by-side
        '';

      # Set Sirula Config
      "sirula/config.toml".source = dot-config + "/sirula-conf.toml";
      "sirula/style.css".source = dot-config + "/sirula-style.css";

      # Zellij
      # "zellij/config.kdl".source = dot-config + "/zellij/config.kdl";
      
      # Hyprland Config Files
      "hypr/hyprland.conf".source = hyprlandFiles + "/hyprland.conf";
      "hypr/hyprland.conf".onChange =
        "/run/current-system/sw/bin/hyprctl reload || echo 'Error occurred, is hyprland running?'"; # useful for hyprland
      "hypr/hyprlock.conf".source = hyprlandFiles + "/hyprlock.conf";
      "hypr/hypridle.conf".source = hyprlandFiles + "/hypridle.conf";
      "wpaperd/config.toml".source = hyprlandFiles + "/wpaper.conf";
      "hypr/hyprpaper.conf".text =
        # conf
        ''
          preload = ~/.nixos/assets/wallpapers/topdownforest.jpg
          wallpaper = ,~/.nixos/assets/wallpapers/topdownforest.jpg
        '';

      "waybar/config".source = hyprlandFiles + "/waybar.conf";
      "waybar/config".onChange =
        "/run/current-system/sw/bin/pkill waybar && /run/current-system/sw/bin/waybar & disown";
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
        theme = if config.theme.dark then "doom-one" else "flatwhite";
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
        font-size = 12;
        font-family = "JetBrainsMono Nerd Font Mono";
        # theme="light:Builtin Solarized Light,dark:Builtin Solarized Dark";
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

    zoxide.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      userName = "Cameron Dugan";
      userEmail = "me@camerondugan.com";
      ## desktop only setup rn
      signing.key = "5A39B85F7BEE2BB880AF0F72A6E4FD72C9C868ED";
      extraConfig.commit.gpgsign = true;
      # editor = "hx";
      difftastic.enable = true;
      # settings = {
      # user.name = "Cameron Dugan";
      # user.email = "cameron.dugan@protonmail.com";
      # core.editor = "hx";
      # pull.rebase = true;
      # };
    };

    # difftastic = {
    #   enable = true;
    #   git.enable = true;
    #   git.diffToolMode = true;
    # };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        # obs-webkitgtk
      ];
    };

    ## Makes Hyprland a Desktop Environment
    caelestia = {
      enable = true;
      settings = {
        border.rounding = 15;
        border.thickness = 1;
        paths.sessionGif = "~/.nixos/assets/waddle.gif";
        paths.wallpaperDir = "~/.nixos/assets/wallpapers/";
        launcher.showOnHover = true;
        bar.status.showAudio = true;
        # bar.status.showMicrophone = true;
        bar.tray.recolour = true;
        idle.lockBeforeSleep = true;
        idle.inhibitWhenAudio = true;
      };
    };
  };
}
