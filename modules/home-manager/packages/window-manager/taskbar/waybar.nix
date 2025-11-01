{
  config,
  systemSettings,
  userSettings,
  pkgs,
  ...
}:

let
  idleIcon = pkgs.writeShellApplication {
    name = "idle-icon";
    text = ''
      if ! systemctl --user is-active hypridle > /dev/null; then
          printf "󱡥"
      fi
    '';
  };
in
{
  programs.waybar = {
    enable = true;
    settings = {

      mainBar = {
        output = [ "*" ];
        layer = "top";
        position = "left";
        width = 54;
        margin-top = 10;
        margin-bottom = 10;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "hyprland/window"
          "hyprland/submap"
          "custom/idle"
          "bluetooth"
          "wireplumber"
          "custom/battery"
          "clock"
          "clock#time"
          "tray"
        ];

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };

        "clock" = {
          justify = "center";
          format = "{:%a\n%b\n%d}";
          timezone = "${systemSettings.location.timezone}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        "clock#time" = {
          format = "{:%H\n%M}";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-click = "activate";
        };

        "wireplumber" = {
          format = "{icon}\n{volume}";
          format-muted = " ";
          justify = "center";
          on-click = "${userSettings.terminal.name} --class floating -e pulsemixer";
          format-icons = [
            ""
            ""
            " "
          ];
        };

        "custom/battery" = {
          format = "{}";
          justify = "center";
          interval = 15;
          exec = "battery-status";
          return-type = "json";
        };

        "custom/idle" = {
          exec = "${idleIcon}/bin/idle-icon";
          format = "{}";
          tooltip-format = "Idle inhibitor is on.";
          signal = 1;
        };

        "bluetooth" = {
          format = "󰂯";
          format-off = ""; # an empty format will hide the module
          format-connected = "󰂱\n{num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };

        "hyprland/window" = {
          icon = true;
          rotate = 90;
          max-length = 102;
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}
