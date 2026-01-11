{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

let
  runPrompt = "  launch";

  startupScript = pkgs.writeShellApplication {
    name = "startup";
    runtimeInputs = with pkgs; [
      waybar
      swaybg
      xorg.xrdb
    ];
    text = ''
      waybar &
      swaync &
      nm-applet &

      current_wallpaper=~/.local/share/current-wallpaper
      [ ! -f "$current_wallpaper" ] && current_wallpaper=${userSettings.windowManager.wallpaper}
      swaybg -i "$current_wallpaper" -m fill &
      xrdb ~/.Xresources &

      sleep 2
      pw-play ~/.local/share/system-sounds/logon.wav &
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
        "XCURSOR_SIZE,${builtins.toString userSettings.windowManager.cursorSize}"
      ];

      general = {
        border_size = 3;
        gaps_out = 10;
        gaps_in = 5;
        layout = "master";

        "col.active_border" = "rgb(66cccc) rgb(339999) rgb(2d8686) rgb(1cb06d) 90deg";
        "col.inactive_border" = "rgb(5a5a5a) rgb(141414) rgb(0d0d0d) rgb(3c3c3c) 90deg";
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
        rounding = 4;

        shadow = {
          enabled = true;
          range = 16;
          render_power = 5;
          color = "rgba(0,0,0,0.35)";
        };

        blur = {
          enabled = true;
          size = 2;
          passes = 1;
          noise = 0;
        };
      };

      xwayland.force_zero_scaling = true;

      "$mfact_split" = "0.55";
      master = {
        new_status = "master";
        new_on_top = true;
        mfact = "$mfact_split";
      };

      misc = {
        force_default_wallpaper = 0;

        enable_swallow = true;
        swallow_regex = "${userSettings.terminal.title}";

        on_focus_under_fullscreen = 1;
        animate_manual_resizes = true;

        vrr = 1;
      };

      cursor = {
        inactive_timeout = 4;
      };

      "$animation_speed" = 2;
      animations.enabled = true;

      animation = [
        "windows, 1, $animation_speed, default, popin 80%"
        "border, 1, $animation_speed, default"
        "fade, 1, $animation_speed, default"
        "workspaces, 1, $animation_speed, default, slidevert"
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

      # varaibles used for keybind modules.
      "$mod" = "SUPER";
      "$wofi" = "pkill wofi ; wofi -i --show drun -p '${runPrompt}'";
      "$wofi_cmd" = "pkill wofi ; wofi -i --show run -p '${runPrompt} command'";
    };
  };
}
