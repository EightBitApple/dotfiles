{
  config,
  systemSettings,
  userSettings,
  pkgs,
  ...
}:

let
  iconBattery = "${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/devices/battery.png";

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
        position = "top";
        height = 36;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-right = [
          "hyprland/submap"
          "bluetooth"
          "wireplumber"
          "custom/battery"
          "clock"
          "custom/idle"
          "tray"
        ];

        "hyprland/window" = {
          icon = true;
          icon-size = 21;
        };

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };

        "clock" = {
          format = "{:%a %b %d %H:%M}";
          timezone = "${systemSettings.location.timezone}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        "hyprland/workspaces" = {
          format = "{}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-click = "activate";
        };

        "wireplumber" = {
          format = "{icon}  {volume}%";
          format-muted = " ";
          on-click = "${userSettings.terminal.name} -e pulsemixer";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        "custom/battery" = {
          format = "{}";
          interval = 15;
          exec = "battery-status";
          on-click = ''
            notify-send -i ${iconBattery} "Battery Information:" "$(battery-info)"
          '';
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
          format-connected = "󰂱 {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}
