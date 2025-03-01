{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod CTRL, H, exec, changevolume mute"
      ", XF86AudioMute, exec, changevolume mute"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

      "$mod CTRL, K, exec, changevolume up 5"
      "$mod CTRL ALT, K, exec, changevolume up 1"
      ", XF86AudioRaiseVolume, exec, changevolume up 5"
      "SHIFT, XF86AudioRaiseVolume, exec, changevolume up 1"

      "$mod CTRL, J, exec, changevolume down 5"
      "$mod CTRL ALT, J, exec, changevolume down 1"
      ", XF86AudioLowerVolume, exec, changevolume down 5"
      "SHIFT, XF86AudioLowerVolume, exec, changevolume down 1"
      "SUPER SHIFT, S, pass, class:^(com\.obsproject\.Studio)$"
    ];
  };
}
