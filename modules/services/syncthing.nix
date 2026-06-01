{
  flake.nixosModules.syncthing = {
    services.syncthing = {
      enable = true;
      user = "cam";
      dataDir = "/home/cam"; # wiki was bad/wrong
      configDir = "/home/cam/.config/syncthing"; # my config better
    };
  };
}
