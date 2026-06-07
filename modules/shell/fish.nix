{
  flake.nixosModules.fish =
    { pkgs, ... }:
    {
      programs.starship.enable = true;
      programs.fish = {
        enable = true;
        interactiveShellInit =
          # fish
          ''
            set fish_greeting
            fish_vi_key_bindings
            bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
            bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace
            fish_add_path /home/cam/.cargo/bin
            enable_transience
            # ZELLIJ AUTOSTART
            # # set ZELLIJ_AUTO_EXIT "true"
            # if not set -q ZELLIJ
            #   if test "$ZELLIJ_AUTO_ATTACH" = "true"
            #     zellij attach -c
            #   else
            #     zellij
            #   end

            #   if test "$ZELLIJ_AUTO_EXIT" = "true"
            #     kill $fish_pid
            #   end
            # end
          '';
        shellAliases = {
          sl = "sl -ew";
          g = "${pkgs.lazygit}/bin/lazygit";
          lg = "${pkgs.lazygit}/bin/lazygit";
          j = "${pkgs.just}/bin/just";
          jm = "${pkgs.just}/bin/just -f makefile";
          jM = "${pkgs.just}/bin/just -f Makefile";
          ls = "${pkgs.eza}/bin/eza --icons always";
          lt = "${pkgs.eza}/bin/eza --icons always -TL2";
          dg = "BROWSER=${pkgs.lynx}/bin/lynx ${pkgs.ddgr}/bin/ddgr";
        };
        shellAbbrs = {
          # Shows to the user the longer command
          # Force use of better commands
          m = "make";
          # cd = "z";
          np = "nix-shell --run fish -p";
          "-" = "cd -";
          # TTY web searching
        };
      };
      environment.systemPackages = with pkgs; [
        grc
        lazygit
        just
        fzf
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
