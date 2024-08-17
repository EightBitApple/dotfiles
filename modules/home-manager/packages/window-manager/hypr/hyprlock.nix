{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options = {
    hyprlock.enable = lib.mkEnableOption ''
      Enable and configure Hyprlock.
    '';
  };

  config = lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [ { path = "${userSettings.wallpaperLock}"; } ];

        label = [
          {
            text = "$TIME";
            text_align = "center";
            font_family = "${userSettings.sansSerifFont}";
            font_size = 32;
            color = "rgb(238,238,238)";

            position = "0, 80";
            halign = "center";
            valign = "center";

            shadow_passes = 2;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "250, 50";
            position = "0, -80";
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            fail_color = "rgb(204, 34, 34)";
            outline_thickness = 5;
            placeholder_text = "<span foreground='##cad3f5'>Password...</span>";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
