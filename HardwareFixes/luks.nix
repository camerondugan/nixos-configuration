{pkgs, lib, ...}:
{
  # Setup keyfile
  boot.initrd.secrets = {
     "/crypto_keyfile.bin" = null;
  };
}
