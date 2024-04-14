{ config, lib, pkgs, ... }:

{
  options.dnscrypt.enable = lib.mkEnableOption ''
    Enable encrypted DNS queries via dnscrypt-proxy2.
  '';

  config = lib.mkIf config.dnscrypt.enable {
    services.dnscrypt-proxy2 = { enable = true; };
  };
}
