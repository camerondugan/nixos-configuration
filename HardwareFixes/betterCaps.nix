{ pkgs, ... }:

{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            # "1" = "!";
            # "2" = "@";
            # "3" = "#";
            # "4" = "$";
            # "5" = "%";
            # "6" = "^";
            # "7" = "&";
            # "8" = "*";
            # "9" = "(";
            # "0" = ")";
          }; 
          shift = {
            # "1" = "1";
            # "2" = "2";
            # "3" = "3";
            # "4" = "4";
            # "5" = "5";
            # "6" = "6";
            # "7" = "7";
            # "8" = "8";
            # "9" = "9";
            # "0" = "0";
          };
          # otherlayer = {};
        };
      };
    };
  };

  # Optional, but makes sure that when you type the make palm rejection work with keyd
  # https://github.com/rvaiya/keyd/issues/723
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
