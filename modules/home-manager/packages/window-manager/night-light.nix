{ config, lib, pkgs, ... }:

{
  options.nightLight.enable = lib.mkEnableOption ''
    Install and configure the Gammastep night light filter.
  '';

  config = lib.mkIf config.nightLight.enable {
    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 50.059444;
      longitude = -1.155556;
    };
  };
}
