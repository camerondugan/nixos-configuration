{ ... }:
{
  flake.nixosModules.hypr =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      environment = {
        systemPackages = with pkgs; [
          fuzzel # Stupid fast Wayland app launcher
          nwg-dock-hyprland # dock
          kitty # backup term
          seahorse # secret manager
          gnome-keyring # keyring
          hyprls # lsp for config editors
          bluetui # tui for bluetooth control
          # pulsemixer # tui that replaces pavucontrol
          inputs.customized-pulsemixer.packages.${pkgs.system}.default
          # sunsetr
          hyprpicker
          inputs.caelestia-shell.packages.${pkgs.system}.default
          inputs.caelestia-cli.packages.${pkgs.system}.default
        ];

        sessionVariables.NIXOS_OZONE_WL = "1";
        sessionVariables.MOZ_ENABLE_WAYLAND = 1;
      };
      wayland.windowManager.hyprland.configType = "hyprlang"; # too lazy to move to lua

      programs = {
        hyprland.enable = true;
        # Disabled because using other shell
        # hyprlock.enable = true;
        dconf.enable = true;
      };

      services = {
        # Login Manager
        displayManager.ly.enable = true;

        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;

        pipewire.enable = true;
        pipewire.wireplumber.enable = true;
        # hypridle.enable = true; # Screen lock and shutdown
        blueman.enable = true; # Bluetooth
        udisks2.enable = true; # Enable mounting service.
      };

      # KDE connect
      xdg.portal.config.common.default = "gtk";
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        kdePackages.xdg-desktop-portal-kde
      ];
      networking.firewall.interfaces.enp42s0 = {
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
      }; # trash
      security.pam.services.cam.enableGnomeKeyring = true;
      security.pam.services.hyprland.enableGnomeKeyring = true;
      networking.networkmanager.enable = true;
    };
}
