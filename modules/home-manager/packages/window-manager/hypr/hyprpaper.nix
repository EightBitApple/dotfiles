{ userSettings, ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = with userSettings; {
      splash = false;
      ipc = true;
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };
}
