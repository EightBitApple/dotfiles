{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.bind = [
    # system state
    "$mod, Backspace, exec, sysact"
    "$mod CTRL, L, exec, gtklock"
    "$mod, M, exit"

    # screenshots
    "$mod, C, exec, pgrep screenshot || screenshot"
    "$mod, V, exec, img-edit"

    # devices
    "$mod SHIFT, B, exec, bt-toggle"
    "$mod CTRL, B, exec, bt-disconnect"
  ];
}
