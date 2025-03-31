{ systemSettings, ... }:

{
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = systemSettings.location.latitude;
    longitude = systemSettings.location.longitude;

    temperature = {
      day = 6500;
      night = 2500;
    };
  };
}
