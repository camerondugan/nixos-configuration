{ ... }:
{
  flake.nixosModules.cosmic =
    { ... }:
    {
      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;
      services.system76-scheduler.enable = false;
    };
}
