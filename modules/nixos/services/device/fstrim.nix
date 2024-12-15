{
  config,
  lib,
  systemSettings,
  ...
}:

{
  services.fstrim = {
    enable = true;
    interval = "${systemSettings.maintenanceDay}";
  };
}
