{
  flake.nixosModules.office = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      onlyoffice-desktopeditors
      papers
    ];
  };
}
