{
  config,
  lib,
  systemSettings,
  ...
}:

{
  options.fstrim.enable = lib.mkEnableOption ''
    Enable fstrim to trim SSDs on a weekly bases.
  '';

  config = lib.mkIf config.fstrim.enable {
    services.fstrim = {
      enable = true;
      interval = "${systemSettings.maintenanceDay}";
    };
  };
}
