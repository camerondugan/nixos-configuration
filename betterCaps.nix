{ pkgs, ... }:

{
  # users.users.cam.extraGroups = ["uinput"];
  # environment.systemPackages = with pkgs; [
  #   kanata
  # ];
  # services = {
  #     kanata.enable = true;
  #     kanata.keyboards."default".config = ''
  #     ;; Caps to escape/control configuration for Kanata
  #     (defsrc
  #       caps
  #     )
  #     (defalias
  #       escctrl (tap-hold 100 100 esc lctl)
  #     )
  #     (deflayer base
  #       @escctrl
  #     )
  #     '';
  # };
}
