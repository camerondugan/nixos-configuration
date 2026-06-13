{...}: {
  flake.nixosModules.whichkey = {pkgs, ...}: {
    # You should be able to configure the de or wm you use to launch this on a hotkey
    environment.systemPackages = with pkgs; [wlr-which-key];
  };
}
