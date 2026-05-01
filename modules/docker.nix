{...}: {
  flake.nixosModules.docker = {...}: {
    users.users.cam.extraGroups = [
      "docker"
    ];
    virtualisation = {
      docker.enable = true;
    };
  };
}
