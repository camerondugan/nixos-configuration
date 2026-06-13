{...}: {
  flake.nixosModules.fish = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      interactiveShellInit =
        # bash
        ''
          set fish_greeting
          fish_vi_key_bindings
          bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
          bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace
          fish_add_path /home/cam/.cargo/bin
          enable_transience
          # set ZELLIJ_AUTO_EXIT "true"
          if not set -q ZELLIJ
            if test "$ZELLIJ_AUTO_ATTACH" = "true"
              zellij attach -c
            else
              zellij
            end

            if test "$ZELLIJ_AUTO_EXIT" = "true"
              kill $fish_pid
            end
          end
        '';
      shellAliases = {
        # Doesn't show these changes to user
        # force safer rm
        rm = "rmtrash";
        rmdir = "rmdirtrash";
        sl = "sl -ew";
      };
      shellAbbrs = {
        # Shows to the user the longer command
        # Force use of better commands
        m = "make";
        jm = "just -f makefile";
        jM = "just -f Makefile";
        g = "lazygit";
        lg = "lazygit";
        # cd = "z";
        ls = "eza --icons always";
        lt = "eza --icons always -TL2";
        np = "nix-shell --run fish -p";
        gi = "gi >> .gitignore"; # append to gitignore
        ns = "nix-shell";
        du = "dust";
        j = "just";
        # Kitty specific
        s = "kitten ssh";
        "-" = "cd -";
        # TTY web searching
        dg = "BROWSER=lynx ddgr";
      };
    };
    environment.systemPackages = with pkgs; [
      # Shell
      fishPlugins.colored-man-pages
      fishPlugins.done
      fishPlugins.forgit
      fishPlugins.fzf
      fishPlugins.grc
      fishPlugins.pisces
      fishPlugins.puffer
      fishPlugins.z
    ];
  };
}
