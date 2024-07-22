{ config, lib, ... }:

{
  options.tlp.enable = lib.mkEnableOption ''
    Enable and configure the tlp power management service.
  '';

  config = lib.mkIf config.tlp.enable { services.tlp.enable = true; };
}
