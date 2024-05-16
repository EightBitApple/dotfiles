{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod ALT, W, exec, hyprctl keyword monitor DP-1,1920x1080@75,0x0,1 & notify-send -t 2000 'Refresh Rate: Max'"
      "$mod ALT, S, exec, hyprctl keyword monitor DP-1,1920x1080@60,0x0,1 & notify-send -t 2000 'Refresh Rate: 60hz'"
    ];
    monitor = [
      "DP-1,1920x1080@75,0x0,1"
      "DP-2,1920x1080@60,1920x0,1,transform,1"
      "HDMI-A-1,1920x1080@60,0x0,1"
    ];
  };
}
