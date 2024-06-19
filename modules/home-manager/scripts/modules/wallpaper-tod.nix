{
  config,
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:

let
  wallTimeOfDay = pkgs.writeShellApplication {
    name = "wall-time-of-day";
    runtimeInputs = with pkgs; [ sunwait ];
    text = ''
      if [ "$(sunwait poll ${systemSettings.latitude}N ${systemSettings.longitude}E)" == "DAY" ];
      then
        hyprctl hyprpaper wallpaper ",${userSettings.wallpaperDay}"
      else
        hyprctl hyprpaper wallpaper ",${userSettings.wallpaperNight}"
      fi
    '';
  };
in
{
  options.wallpaperTod.enable = lib.mkEnableOption ''
    Enable script to change wallpaper between day and night varients based on time of day.
  '';

  config = lib.mkIf config.wallpaperTod.enable {
    home.packages = with pkgs; [ wallTimeOfDay ];

    systemd.user.services."wallpaper-time-of-day" = {
      Unit.Description = "Run script to change wallpaper based on whether it's day or night.";
      Install.WantedBy = [ "default.target" ];

      Service.ExecStart = "${wallTimeOfDay}/bin/wall-time-of-day";
    };

    systemd.user.timers."wallpaper-time-of-day" = {
      Unit.Description = "Timer to run script to change wallpaper based on whether it's day or night.";
      Install.WantedBy = [ "timers.target" ];

      Timer = {
        Unit = "wallpaper-time-of-day.service";
        OnBootSec = "30m";
        OnUnitActiveSec = "30m";
        Persistent = true;
      };
    };
  };
}
