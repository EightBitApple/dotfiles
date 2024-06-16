{
  config,
  lib,
  pkgs,
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
        preload = [ "${wallpaper}" ];
        wallpaper = [ ",${wallpaper}" ];
      };
    };
  };
}
