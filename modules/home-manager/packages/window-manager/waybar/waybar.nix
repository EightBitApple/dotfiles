{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    waybar.enable = lib.mkEnableOption ''
      Install and configure Waybar.
    '';
  };

  config = lib.mkIf config.waybar.enable {
    programs = {
      waybar = {
        enable = true;
        settings = {

          mainBar = {
            output = [ "*" ];
            layer = "top";
            position = "top";
            modules-left = [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-right = [
              "wireplumber"
              "battery#controller"
              "battery#bat0"
              "battery#bat1"
              "bluetooth"
              "network"
              "clock"
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
              timezone = "Europe/London";
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
            };

            "network" = {
              format-wifi = "  {signalStrength}%";
              format-ethernet = "󰈀";
              tooltip-format = ''
                {ifname}	{ipaddr}/{cidr}
                gateway	{gwaddr}
                	{essid}
                {icon}  ⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}'';
              format-disconnected = "󰅛";
              on-click = "alacritty -e nmtui";
            };

            "battery#controller" = {
              bat = "ps-controller-battery-7c:66:ef:40:6f:00";
              interval = 30;
              on-update = "bat-warning";
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon}  {capacity}%";
              format-icons = [
                "󰝌"
                "󰝎"
                "󰝏"
                "󰝍"
              ];
            };

            "battery#bat0" = {
              bat = "BAT0";
              interval = 30;
              on-update = "bat-warning";
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon}  {capacity}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };

            "battery#bat1" = {
              bat = "BAT1";
              interval = 30;
              on-update = "bat-warning";
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon}  {capacity}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };

            "hyprland/workspaces" = {
              format = "{}";
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
              on-click = "activate";
            };

            "wireplumber" = {
              format = "{icon}  {volume}%";
              format-muted = "";
              on-click = "alacritty -e pulsemixer";
              format-icons = [
                ""
                ""
                ""
              ];
            };
            "bluetooth" = {
              format = "󰂯 {status}";
              format-off = ""; # an empty format will hide the module
              format-connected = "󰂱 {num_connections}";
              tooltip-format = "{controller_alias}\t{controller_address}";
              tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            };
          };
        };
        style = with config.stylix.base16Scheme; ''
          * {
              border: none;
              border-radius: 2px;
              font-family: FiraCode Nerd Font;
              font-size: 11px;
              font-weight: 500;
              min-height: 0;
          }

          /* Waybar */
          window#waybar {
              background-color: #${base00};
              padding-bottom: 3px;
              color: #${base07};
              border-radius: 0;
          }

          #window {
              padding-left: 10px;
              padding-right: 10px;
              color: #${base04};
          }

          #workspaces button {
              padding: 0 0.4em;
              background-color: transparent;
              color: #${base07};
          }

          #workspaces button:hover {
              background-color: #${base03};
          }

          #workspaces button.active {
              background-color: #${base07};
              color: #${base00};
          }

          #workspaces button.urgent {
              background-color: #${base09};
              color: #${base00};
          }

          /* If workspaces is the leftmost module, omit top margin */
          .modules-left > widget:first-child > #workspaces {
              margin-top: 0.25em;
          }

          tooltip {
              color: #${base07};
              background-color: #${base00};
              box-shadow: 2px 2px;
          }

          #battery.charging {
              color: #${base0B};
          }

          #battery.warning {
              color: #${base0A};
          }

          #battery.critical:not(.charging) {
              color: #${base08};
          }

          #clock.date,
          #clock,
          #network,
          #wireplumber,
          #battery.controller,
          #battery.bat0,
          #battery.bat1,
          #bluetooth,
          #tray {
            padding: 0 10px;
            margin: 6px 2px;
            color: #${base04};
          }

          #wireplumber.muted,
          #network.disconnected {
              color: #${base03};
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }
          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #${base08};
          }
        '';
      };
    };
  };
}
