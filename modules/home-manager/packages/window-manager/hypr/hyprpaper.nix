{
  config,
  lib,
  userSettings,
  ...
}:

{
  services.hyprpaper = {
    enable = true;

    settings = with userSettings; {
      splash = false;
      ipc = true;
      preload = [
        "${wallpaperDay}"
        "${wallpaperNight}"
        "${wallpaperNeutral}"
      ];
      wallpaper = [ ",${wallpaperNeutral}" ];
    };
  };
}
