{ pkgs, ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    bind = SHIFT CTRL, Return, submap, airmouse
    submap = airmouse

    # app launchings
    bind = CTRL, D, exec, $wofi
    bind = CTRL, End, exec, pkill wofi
    bind = CTRL, E, exec, caja

    bind=CTRL, X, exec, emacsclient -c
    bind=CTRL, Return, exec, ${pkgs.alacritty}/bin/alacritty

    # media keys
    bind=, XF86AudioRaiseVolume, exec, changevolume up 5
    bind=, XF86AudioLowerVolume, exec, changevolume down 5

    # workspaces
    bind = CTRL, 1, workspace, 1
    bind = CTRL SHIFT, 1, movetoworkspacesilent, 1
    bind = CTRL, 2, workspace, 2
    bind = CTRL SHIFT, 2, movetoworkspacesilent, 2
    bind = CTRL, 3, workspace, 3
    bind = CTRL SHIFT, 3, movetoworkspacesilent, 3
    bind = CTRL, 4, workspace, 4
    bind = CTRL SHIFT, 4, movetoworkspacesilent, 4
    bind = CTRL, 5, workspace, 5
    bind = CTRL SHIFT, 5, movetoworkspacesilent, 5
    bind = CTRL, 6, workspace, 6
    bind = CTRL SHIFT, 6, movetoworkspacesilent, 6
    bind = CTRL, 7, workspace, 7
    bind = CTRL SHIFT, 7, movetoworkspacesilent, 7
    bind = CTRL, 8, workspace, 8
    bind = CTRL SHIFT, 8, movetoworkspacesilent, 8
    bind = CTRL, 9, workspace, 9
    bind = CTRL SHIFT, 9, movetoworkspacesilent, 9
    bind = CTRL, 0, workspace, 10
    bind = CTRL SHIFT, 0, movetoworkspacesilent, 10

    # scaling
    bind=CTRL, I, exec, hyprctl keyword monitor DP-1, highres, auto, 2
    bind=CTRL SHIFT, I, exec, hyprctl keyword monitor DP-1, highres, auto, 1

    # window management
    bind=CTRL, J, cyclenext
    bind=CTRL, K, cyclenext, prev
    bind=CTRL SHIFT, J, swapnext
    bind=CTRL SHIFT, K, swapnext, prev
    bind=CTRL, F, fullscreen, 1
    bind=CTRL SHIFT, F, fullscreen, 0
    bind=CTRL, Q, killactive

    bind = SHIFT CTRL, Return, submap, reset
    submap = reset
  '';
}
