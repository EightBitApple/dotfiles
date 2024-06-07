{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

let
  startupScript = pkgs.writeShellApplication {
    name = "startup";
    runtimeInputs = with pkgs; [
      waybar
      hyprpaper
      foot
      xorg.xrdb
    ];
    text = ''
      waybar &
      hyprpaper &
      foot --server &
      xrdb -load ~/.Xresources
    '';
  };
in
{
  options = {
    hyprland.enable = lib.mkEnableOption ''
      Configure the Hyprland window manager.
    '';

    hyprlandDisplay1 = lib.mkOption { default = "DP-1"; };
    hyprlandDisplay2 = lib.mkOption { default = "DP-2"; };
    hyprlandDisplay3 = lib.mkOption { default = "HDMI-A-1"; };
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {

        "$display1" = config.hyprlandDisplay1;
        "$display2" = config.hyprlandDisplay2;
        "$display3" = config.hyprlandDisplay3;

        exec-once = "${startupScript}/bin/startup";

        env = [
          "XCURSOR_SIZE,24"
          "LSP_USE_PLISTS,true"
        ];

        general = with config.colorScheme.palette; {
          border_size = 2;
          gaps_out = 10;
          cursor_inactive_timeout = 4;
          layout = "master";

          "col.active_border" = "rgba(${base09}ff) rgba(${base0E}ff) 60deg";
          "col.inactive_border" = "rgba(${base00}ff)";
        };

        input = {
          kb_layout = "gb";
          kb_options = "caps:escape_shifted_capslock";

          follow_mouse = 1;
          mouse_refocus = true;

          touchpad = {
            natural_scroll = "no";
          };

          repeat_delay = 300;
          repeat_rate = 50;
        };

        decoration = {
          drop_shadow = false;
          rounding = 2;

          blur = {
            enabled = false;
            size = 2;
          };
        };

        xwayland.force_zero_scaling = true;

        "$mfact_split" = "0.55";
        master = {
          new_is_master = true;
          new_on_top = true;
          mfact = "$mfact_split";
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        gestures.workspace_swipe = "off";

        workspace = [
          "1, monitor:$display1"
          "2, monitor:$display1"
          "3, monitor:$display1"
          "4, monitor:$display1"
          "5, monitor:$display1"
          "6, monitor:$display2"
          "7, monitor:$display2"
          "8, monitor:$display2"
          "9, monitor:$display2"
          "10, monitor:$display2"
        ];

        misc = {
          force_default_wallpaper = 0;

          enable_swallow = true;
          swallow_regex = "(footclient)";

          new_window_takes_over_fullscreen = 1;
          animate_manual_resizes = true;
          vrr = 1;
        };

        "$animation_speed" = 2;
        animations = {
          enabled = "no";
          bezier = "overshot, 0.05, 0.9, 0.1, 1.05";
        };

        animation = [
          "windows, 1, $animation_speed, overshot, popin 80%"
          "border, 1, $animation_speed, overshot"
          "fade, 1, $animation_speed, overshot"
          "workspaces, 1, $animation_speed, overshot, slidevert"
        ];

        windowrulev2 = [
          "float,title:(Authentication Required — PolicyKit1 KDE Agent)$"
          "float,title:^(File Operation Progress)$"
          "noanim,class:^(Gimp)$"
          "stayfocused, title:^()$,class:^(steam)$"
          "minsize 1 1, title:^()$,class:^(steam)$"
        ];

        layerrule = [
          "blur, launcher"
          "blur, notifications"
        ];

        "$mod" = "SUPER";

        bind = [

          "$mod, Q, killactive"
          "$mod, F, fullscreen, 0"

          "$mod SHIFT, Space, togglefloating"
          "$mod SHIFT, Space, resizeactive, exact 50% 50%"
          "$mod SHIFT, Space, centerwindow, 1"

          "$mod CTRL, Space, togglefloating"
          "$mod CTRL, Space, resizeactive, exact 33% 33%"
          "$mod CTRL, Space, movewindow, d"
          "$mod CTRL, Space, movewindow, r"
          "$mod CTRL, Space, pin"

          "$mod, Return, exec, footclient"

          "$mod, P, exec, foot pulsemixer"

          "$mod SHIFT, R, exec, foot htop"

          "$mod, X, exec, emc"
          "$mod SHIFT, X, exec, emc -r"
          "$mod, W, exec, firefox"
          "$mod CTRL, W, exec, brave"

          "$mod, E, exec, Thunar"

          "$mod, R, exec, tofi-run | xargs hyprctl dispatch exec --"
          "$mod CTRL, L, exec, physlock -m -s"

          "$mod, C, exec, screenshot"
          "$mod, V, exec, img-edit"

          "$mod, B, exec, pkill -SIGUSR1 waybar"

          "$mod, M, exit,"
          "$mod, Backspace, exec, sysact"

          "$mod CTRL, H, exec, changevolume mute"
          ", XF86AudioMute, exec, changevolume mute"

          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"

          "$mod, J, layoutmsg, cyclenext"
          "$mod, K, layoutmsg, cycleprev"

          "$mod SHIFT, J, layoutmsg, swapnext"
          "$mod SHIFT, K, layoutmsg, swapprev"

          "$mod, Space, layoutmsg, swapwithmaster"
          "$mod SHIFT, F, layoutmsg, focusmaster"

          "$mod, I, layoutmsg, orientationcenter"

          "$mod, T, layoutmsg, orientationleft"

          "$mod, A, movewindow, mon:$display1"
          "$mod, D, movewindow, mon:$display2"
          "$mod SHIFT, A, movecurrentworkspacetomonitor, $display1"
          "$mod SHIFT, D, movecurrentworkspacetomonitor, $display2"
        ];

        binde = [

          "$mod CTRL, K, exec, changevolume up 5"
          ", XF86AudioRaiseVolume, exec, changevolume up 5"

          "$mod CTRL, J, exec, changevolume down 5"
          ", XF86AudioLowerVolume, exec, changevolume down 5"

          "$mod, L, resizeactive, 25 0"
          "$mod, H, resizeactive, -25 0"
        ];

        bindm = [

          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
