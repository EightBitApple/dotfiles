{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    hypridle.enable = lib.mkEnableOption ''
      Enable and configure Hypridle
    '';
  };

  config = lib.mkIf config.hypridle.enable {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock";
          ignore_dbus_inhibit = false;
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
          }
          {
            timeout = 500;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
