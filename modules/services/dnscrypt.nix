{ config, lib, pkgs, ... }:

{
  options.dnscyrpt.enable = lib.mkEnableOption ''
    Enable encrypted DNS queries via dnscrypt-proxy2.
  '';

  config = lib.mkIf config.dnscyrpt.enable {
    services.dnscrypt-proxy2 = { enable = true; };
  };
}
