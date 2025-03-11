{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      "$mod, Q, killactive"
      "$mod, F, fullscreen, 0"

      # floating windows
      "$mod SHIFT, Space, togglefloating"
      "$mod SHIFT, Space, resizeactive, exact 50% 50%"
      "$mod SHIFT, Space, centerwindow, 1"

      # Place a pinned floating window to the bottom right of screen.
      "$mod CTRL, Space, togglefloating"
      "$mod CTRL, Space, resizeactive, exact 33% 33%"
      "$mod CTRL, Space, movewindow, d"
      "$mod CTRL, Space, movewindow, r"
      "$mod CTRL, Space, pin"
      "$mod CTRL, Space, layoutmsg, mfact exact $mfact_split"

      # workspaces
      "$mod, 1, workspace, 1"
      "$mod SHIFT, 1, movetoworkspacesilent, 1"
      "$mod, 2, workspace, 2"
      "$mod SHIFT, 2, movetoworkspacesilent, 2"
      "$mod, 3, workspace, 3"
      "$mod SHIFT, 3, movetoworkspacesilent, 3"
      "$mod, 4, workspace, 4"
      "$mod SHIFT, 4, movetoworkspacesilent, 4"
      "$mod, 5, workspace, 5"
      "$mod SHIFT, 5, movetoworkspacesilent, 5"
      "$mod, 6, workspace, 6"
      "$mod SHIFT, 6, movetoworkspacesilent, 6"
      "$mod, 7, workspace, 7"
      "$mod SHIFT, 7, movetoworkspacesilent, 7"
      "$mod, 8, workspace, 8"
      "$mod SHIFT, 8, movetoworkspacesilent, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 9, movetoworkspacesilent, 9"
      "$mod, 0, workspace, 10"
      "$mod SHIFT, 0, movetoworkspacesilent, 10"

      # focusing
      "$mod, J, cyclenext"
      "$mod, K, cyclenext, prev"

      # swapping
      "$mod SHIFT, J, swapnext"
      "$mod SHIFT, K, swapnext, prev"
      "$mod, Space, layoutmsg, swapwithmaster"

      # layouts
      "$mod, I, layoutmsg, orientationcenter"
      "$mod, T, layoutmsg, orientationleft"
      "$mod, T, layoutmsg, mfact exact $mfact_split"

      # multi-monitor
      "$mod SHIFT, L, movecurrentworkspacetomonitor, +1"
      "$mod SHIFT, H, movecurrentworkspacetomonitor, -1"
    ];

    binde = [
      # resizing
      "$mod, L, resizeactive, 25 0"
      "$mod, H, resizeactive, -25 0"
    ];

    bindm = [
      # mouse
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
