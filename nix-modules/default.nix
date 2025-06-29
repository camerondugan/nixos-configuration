{lib, ...}: {
  imports = [
    ./coding
  ];
  coding.enable = lib.mkDefault true;
  coding.terminalPrompt.enable = lib.mkDefault true;
}
