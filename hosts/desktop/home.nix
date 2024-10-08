{ ... }:

{
  imports = [ ../../modules/home-manager ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod ALT, W, exec, hyprctl keyword monitor DP-1,1920x1080@75,0x0,1 & notify-send -t 2000 'Refresh Rate: Max'"
      "$mod ALT, S, exec, hyprctl keyword monitor DP-1,1920x1080@60,0x0,1 & notify-send -t 2000 'Refresh Rate: 60hz'"
    ];
    monitor = [
      "DP-1,1920x1080@75,0x0,1"
      "HDMI-A-1,1920x1080@60,0x0,1"
    ];

    env = [ "WLR_DRM_NO_ATOMIC,1" ];

    cursor = {
      no_break_fs_vrr = true;
      min_refresh_rate = 48;
      no_hardware_cursors = true;
    };
  };
}
