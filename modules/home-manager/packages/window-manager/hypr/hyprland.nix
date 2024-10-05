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
    runtimeInputs = with pkgs; [ waybar ];
    text = ''
      systemctl --user restart hypridle.service
      waybar &

      # Sleep to make sure that Hyprpaper socket is opened before wallpaper
      # script runs!
      systemctl --user restart hyprpaper.service
      sleep 3
      systemctl --user restart wallpaper-time-of-day.service

      emacs --daemon && notify-send -u low "Emacs server running."
    '';
  };

  alacrittyStart = pkgs.writeShellApplication {
    name = "alacritty-start";
    text = ''
      alacritty msg --socket "$XDG_RUNTIME_DIR/alacritty.sock" create-window "$@" \
          || alacritty --socket "$XDG_RUNTIME_DIR/alacritty.sock" "$@"
    '';
  };
in
{
  options = {
    hyprland.enable = lib.mkEnableOption ''
      Configure the Hyprland window manager.
    '';
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = with config.stylix.base16Scheme; {

        exec-once = "${startupScript}/bin/startup";

        env = [ "LSP_USE_PLISTS,true" ];

        general = {
          border_size = 3;
          gaps_out = 10;
          layout = "master";

          "col.active_border" = lib.mkForce "rgb(${base08}) rgb(${base0A}) rgb(${base09}) 60deg";
          "col.inactive_border" = lib.mkForce "rgb(${base03})";
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
          drop_shadow = true;
          rounding = 8;

          blur = {
            enabled = true;
            size = 4;
          };
        };

        xwayland.force_zero_scaling = true;

        "$mfact_split" = "0.6";
        master = {
          new_status = "master";
          new_on_top = true;
          mfact = "$mfact_split";
        };

        gestures.workspace_swipe = "off";

        misc = {
          force_default_wallpaper = 0;

          enable_swallow = true;
          swallow_regex = "${userSettings.terminalTitle}";

          new_window_takes_over_fullscreen = 1;
          animate_manual_resizes = true;

          vrr = 1;
        };

        cursor = {
          inactive_timeout = 4;
        };

        "$animation_speed" = 2;
        animations = {
          enabled = "yes";
          bezier = "overshot, 0.05, 0.9, 0.1, 1.05";
        };

        animation = [
          "windows, 1, $animation_speed, overshot, popin 80%"
          "border, 1, $animation_speed, overshot"
          "fade, 1, $animation_speed, overshot"
          "workspaces, 1, $animation_speed, overshot, slide"
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

          # Place a pinned floating window to the bottom right of screen.
          "$mod CTRL, Space, togglefloating"
          "$mod CTRL, Space, resizeactive, exact 33% 33%"
          "$mod CTRL, Space, movewindow, d"
          "$mod CTRL, Space, movewindow, r"
          "$mod CTRL, Space, pin"
          "$mod CTRL, Space, layoutmsg, mfact exact $mfact_split"

          "$mod, Return, exec, ${alacrittyStart}/bin/alacritty-start"

          "$mod, P, exec, ${alacrittyStart}/bin/alacritty-start -e pulsemixer"

          "$mod SHIFT, R, exec, ${alacrittyStart}/bin/alacritty-start -e htop"

          "$mod, X, exec, emacsclient -c"

          "$mod, W, exec, ${userSettings.browser}"

          "$mod, E, exec, Thunar"

          "$mod, R, exec, tofi-run | xargs hyprctl dispatch exec --"
          "$mod CTRL, L, exec, hyprlock -q"

          "$mod, C, exec, pgrep screenshot || screenshot"
          "$mod, V, exec, img-edit"

          "$mod, B, exec, pkill -SIGUSR1 waybar"

          "$mod, M, exit"
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

          "$mod, J, cyclenext"
          "$mod, K, cyclenext, prev"

          "$mod SHIFT, J, swapnext"
          "$mod SHIFT, K, swapnext, prev"

          "$mod, Space, layoutmsg, swapwithmaster"
          "$mod SHIFT, F, layoutmsg, focusmaster"

          "$mod, I, layoutmsg, orientationcenter"
          "$mod, T, layoutmsg, orientationleft"
          "$mod, T, layoutmsg, mfact exact $mfact_split"
        ];

        binde = [
          "$mod CTRL, K, exec, changevolume up 5"
          "$mod CTRL ALT, K, exec, changevolume up 1"
          ", XF86AudioRaiseVolume, exec, changevolume up 5"
          "SHIFT, XF86AudioRaiseVolume, exec, changevolume up 1"

          "$mod CTRL, J, exec, changevolume down 5"
          "$mod CTRL ALT, J, exec, changevolume down 1"
          ", XF86AudioLowerVolume, exec, changevolume down 5"
          "SHIFT, XF86AudioLowerVolume, exec, changevolume down 1"

          "$mod, L, resizeactive, 25 0"
          "$mod, H, resizeactive, -25 0"

          "$mod SHIFT, L, movecurrentworkspacetomonitor, +1"
          "$mod SHIFT, H, movecurrentworkspacetomonitor, -1"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
