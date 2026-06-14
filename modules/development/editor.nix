{
  flake.homeModules.editor = {pkgs, ...}: {
    programs.helix = {
      enable = true;
      settings = {
        # theme = "base16_default";
        theme = "solarized_dark"; # avoid flashbangs
        # theme.dark = "solarized_dark"; # this should work, not sure why it doesn't.
        # theme.light = "solarized_light";
        # theme.fallback = "solarized_dark"; # avoid flashbangs
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
          ret = ["goto_word"];
          X = ["extend_line_above"];
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
          r = ":toggle line-number relative absolute";
          l = ":theme solarized_light";
          d = ":theme solarized_dark";
        };
        keys.normal.Z = {
          Z = ["wclose"]; # Could not use write_quit since it doesn't exist :(
        };
      };
      languages = {
        # global-language-servers = [
        #   "harper-ls"
        # ];
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
            file-types = ["gd"];
            language-servers = [
              "gdscript"
              "harper-ls"
            ];
          }
        ];

        language-server = {
          harper-ls = {
            command = "${pkgs.harper}/bin/harper-ls";
            args = ["--stdio"];
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
  };
}
