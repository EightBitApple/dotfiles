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
    "$mod, D, exec, $wofi"
    "$mod SHIFT, D, exec, $wofi_cmd"

    # managers
    "$mod, E, exec, caja"

    # misc
    "$mod, B, exec, pkill -SIGUSR1 waybar"
    "$mod SHIFT, W, exec, change-wallpaper -d"
    "$mod SHIFT, L, exec, change-wallpaper -l"
  ];
}
