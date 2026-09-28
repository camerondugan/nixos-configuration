{
  flake.nixosModules.wireguard = { ... }: {
    services.wgautomesh.enable = false;
    # TO-DO: setup wg automesh and ditch the tail sniffer
  };
}
