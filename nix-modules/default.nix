{lib, ...}: {
  imports = [
    ./coding
    ./gaming
  ];
  coding.enable = lib.mkDefault true;
  coding.terminalPrompt.enable = lib.mkDefault true;
  gaming.enable = lib.mkDefault false;
}
