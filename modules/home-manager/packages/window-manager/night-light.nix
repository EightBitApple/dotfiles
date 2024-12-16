{ systemSettings, ... }:

{
  services.gammastep = with systemSettings; {
    enable = true;
    provider = "manual";
    latitude = latitude;
    longitude = longitude;
    temperature = {
      day = 6500;
      night = 2500;
    };
  };
}
