{
  config,
  lib,
  userSettings,
  ...
}:

{
  options.hyprpaper.enable = lib.mkEnableOption ''
    Install hyprpaper to set wallpapers in Hyprland.
  '';

  config = lib.mkIf config.hyprpaper.enable {
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
  };
}
