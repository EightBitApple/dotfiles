{ userSettings, pkgs, ... }:
let
  alacrittyStart = pkgs.writeShellApplication {
    name = "alacritty-start";
    text = ''
      alacritty msg --socket "$XDG_RUNTIME_DIR/alacritty.sock" create-window "$@" \
          || alacritty --socket "$XDG_RUNTIME_DIR/alacritty.sock" "$@"
    '';
  };
in
{
  wayland.windowManager.hyprland.settings.bind = [
    # terminal
    "$mod, Return, exec, ${alacrittyStart}/bin/alacritty-start"
    "$mod, P, exec, ${alacrittyStart}/bin/alacritty-start -e pulsemixer"
    "$mod SHIFT, R, exec, ${alacrittyStart}/bin/alacritty-start -e htop"

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
