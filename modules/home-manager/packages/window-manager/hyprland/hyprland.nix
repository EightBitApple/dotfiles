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
      swaybg
      networkmanagerapplet
    ];
    text = ''
      waybar &
      nm-applet &

      current_wallpaper=~/.local/share/current-wallpaper
      [ ! -f "$current_wallpaper" ] && current_wallpaper=${userSettings.wallpaper}
      swaybg -i "$current_wallpaper" -m fill &
    '';
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = "${startupScript}/bin/startup";

      env = [
        "LSP_USE_PLISTS,true"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XCURSOR_SIZE,${builtins.toString userSettings.cursorSize}"
      ];

      general = {
        border_size = 3;
        gaps_out = 10;
        gaps_in = 5;
        layout = "master";

        "col.active_border" = "rgb(f43841) rgb(ffdd33) rgb(c73c3f) 60deg";
        "col.inactive_border" = "rgb(52494e)";
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
        rounding = 12;
        active_opacity = 1.0;
        inactive_opacity = 1;

        shadow = {
          enabled = true;
          range = 16;
          render_power = 5;
          color = "rgba(0,0,0,0.35)";
        };

        blur = {
          enabled = true;
          new_optimizations = true;
          size = 2;
          passes = 3;
          vibrancy = 0.1696;
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
        vfr = 1;
      };

      cursor = {
        inactive_timeout = 4;
      };

      "$animation_speed" = 2;
      animations = {
        enabled = true;
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

      device = [
        {
          name = "wacom-one-by-wacom-s-pen";
          left_handed = true;
        }
        {
          name = "2.4g-composite-devic";
          kb_layout = "us";
        }
      ];

      layerrule = [
        "blur, wofi"
        "ignorealpha 0.01, wofi" # This is so entirely transparent things aren't blurred.

        "blur, waybar"
        "blurpopups, waybar"
        "ignorealpha 0.01, waybar" # this is so entirely transparent things aren't blurred.

        "blur, swaync-notification-window"
        "ignorealpha 0.01, swaync-notification-window" # this is so entirely transparent things aren't blurred.
      ];

      # varaibles used for keybind modules.
      "$mod" = "SUPER";
      "$wofi" = "pkill wofi ; wofi --show drun -p 'launch:'";
      "$wofi_cmd" = "pkill wofi ; wofi --show run -p 'launch:'";
    };
  };
}
