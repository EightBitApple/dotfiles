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
    ];
    text = ''
      waybar &
      swaybg -i ${userSettings.wallpaper} --mode fill &
    '';
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = with config.stylix.base16Scheme; {

      exec-once = "${startupScript}/bin/startup";

      env = [
        "LSP_USE_PLISTS,true"
        "XDG_CURRENT_DESKTOP,Hyprland"
      ];

      general = {
        border_size = 3;
        gaps_out = 10;
        gaps_in = 5;
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
        shadow.enabled = false;
        rounding = 4;

        blur.enabled = false;
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

      animations.enabled = false;

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
    };
  };
}
