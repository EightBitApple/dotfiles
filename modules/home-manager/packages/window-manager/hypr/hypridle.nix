{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      general.ignore_dbus_inhibit = false;

      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.physlock}/bin/physlock -msp 'Machine locked.'";
        }
      ];
    };
  };
}
