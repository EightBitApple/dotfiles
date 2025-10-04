{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        before_sleep_cmd = "${pkgs.gtklock}/bin/gtklock";
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.gtklock}/bin/gtklock";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
