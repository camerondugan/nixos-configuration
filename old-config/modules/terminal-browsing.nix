{pkgs, ...}: {
  flake.nixosModules.terminalBrowsing = {...}: {
    environment.systemPackages = with pkgs; [
      ddgr
      lynx
    ];
  };
}
