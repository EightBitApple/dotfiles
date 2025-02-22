{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.bind = [
    # system state
    "$mod, Backspace, exec, sysact"
    "$mod CTRL, L, exec, ${pkgs.physlock}/bin/physlock -msp 'Machine locked.'"
    "$mod, M, exit"

    # screenshots
    "$mod, C, exec, pgrep screenshot || screenshot"
    "$mod, V, exec, img-edit"
  ];
}
