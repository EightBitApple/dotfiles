{ systemSettings, ... }:

{
  services.fstrim = {
    enable = true;
    interval = "${systemSettings.maintenance.day}";
  };
}
