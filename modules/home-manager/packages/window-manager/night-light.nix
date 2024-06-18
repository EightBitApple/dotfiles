{
  config,
  lib,
  pkgs,
  systemSettings,
  ...
}:

{
  options.nightLight.enable = lib.mkEnableOption ''
    Install and configure the Gammastep night light filter.
  '';

  config = lib.mkIf config.nightLight.enable {
    services.gammastep = with systemSettings; {
      enable = true;
      provider = "manual";
      latitude = latitude;
      longitude = longitude;
    };
  };
}
