{lib, ...}: {
  imports = [
    ./Gaming
    ./Coding
  ];
  coding.enable = lib.mkDefault true;
  coding.terminalPrompt.enable = lib.mkDefault true;

  gaming.enable = lib.mkDefault false;
}
