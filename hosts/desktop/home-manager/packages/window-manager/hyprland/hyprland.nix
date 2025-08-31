{ pkgs, ... }:
let
  dispIcon = "${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/devices/video-display.png";
  dispRes = "hyprctl keyword monitor DP-1,1920x1080";
  notifHint = "string:x-canonical-private-synchronous:refresh";
  dispPos = "0x0,1";

  notifCmd = "notify-send -h ${notifHint} -t ${notifTime} -i ${dispIcon}";
  notifTitle = "Refresh Rate";
  notifTime = "2000";
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod ALT, W, exec, ${dispRes}@75,${dispPos} & ${notifCmd} '${notifTitle}' '75Hz'"
      "$mod ALT, S, exec, ${dispRes}@60,${dispPos} & ${notifCmd} '${notifTitle}' '60Hz'"
      "$mod ALT, D, exec, ${dispRes}@50,${dispPos} & ${notifCmd} '${notifTitle}' '50Hz'"
    ];
    monitor = [
      "DP-1, 1920x1080@75, 0x0, 1"
      "DP-2, 1920x1080@60, 1920x-880, 1, transform, 1"
      "HDMI-A-1, 1920x1080@60, 0x0, 1"
    ];

    cursor = {
      no_break_fs_vrr = 1;
      min_refresh_rate = 48;
      no_hardware_cursors = 0;
    };

    render.direct_scanout = 2; # on with content type 'game'
  };
}
