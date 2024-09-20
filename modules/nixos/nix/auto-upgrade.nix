{
  config,
  lib,
  inputs,
  systemSettings,
  ...
}:

{
  options.autoUpgrade.enable = lib.mkEnableOption ''
    Auto upgrade system.
  '';

  config = lib.mkIf config.autoUpgrade.enable {
    system.autoUpgrade = {
      enable = true;
      dates = "${systemSettings.maintenanceDay}";
      randomizedDelaySec = "45min";
      persistent = true;
    };
  };
}
