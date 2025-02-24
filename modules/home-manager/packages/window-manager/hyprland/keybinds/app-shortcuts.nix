{ userSettings, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.bind = [
    # terminal
    "$mod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
    "$mod, P, exec, ${pkgs.alacritty}/bin/alacritty -e pulsemixer"
    "$mod SHIFT, R, exec, ${pkgs.alacritty}/bin/alacritty -e htop"

    # browsers
    "$mod, W, exec, ${userSettings.browser}"

    # editors
    "$mod, X, exec, emacsclient -c"

    # launchers
    "$mod, R, exec, tofi-run --prompt-text='Launch: ' | xargs hyprctl dispatch exec --"

    # managers
    "$mod, E, exec, Thunar"

    # misc
    "$mod, B, exec, pkill -SIGUSR1 waybar"
  ];
}
