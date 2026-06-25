{
  flake.nixosModules.frameworkConf = {
    services.pipewire.alsa.support32Bit = false; # Temporary
    networking.hostName = "Framework13";
    services.fwupd.enable = true;
  };
}
