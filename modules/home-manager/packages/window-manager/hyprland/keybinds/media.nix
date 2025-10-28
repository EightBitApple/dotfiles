{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod CTRL, H, exec, change-volume mute"
      ", XF86AudioMute, exec, change-volume mute"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

      "$mod CTRL, K, exec, change-volume up 5"
      "$mod CTRL ALT, K, exec, change-volume up 1"
      ", XF86AudioRaiseVolume, exec, change-volume up 5"
      "SHIFT, XF86AudioRaiseVolume, exec, change-volume up 1"

      "$mod CTRL, J, exec, change-volume down 5"
      "$mod CTRL ALT, J, exec, change-volume down 1"
      ", XF86AudioLowerVolume, exec, change-volume down 5"
      "SHIFT, XF86AudioLowerVolume, exec, change-volume down 1"
      "$mod, S, pass, class:^(com\.obsproject\.Studio)$"
      "$mod, S, exec, sh obs-clip"
    ];
  };
}
