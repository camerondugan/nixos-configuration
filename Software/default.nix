{lib, ...}: {
  imports = [
    ./gamer.nix
    ./coder.nix
  ];
  coder.enable = lib.mkDefault true;
  coder.terminalPrompt.enable = lib.mkDefault true;

  gamer.enable = lib.mkDefault false;
}
