{
  config,
  lib,
  pkgs,
  systemSettings,
  userSettings,
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
              "custom/battery"
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
              timezone = "${systemSettings.timezone}";
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
              on-click = "${userSettings.terminal} -e nmtui";
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
              on-click = "${userSettings.terminal} -e pulsemixer";
              format-icons = [
                ""
                ""
                ""
              ];
            };

            "custom/battery" = {
              format = "{}";
              interval = 10;
              exec = "battery-status";
              on-click = ''
                notify-send "Battery Information:" "$(battery-info)"
              '';
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
              font-family: ${userSettings.monospaceFont};
              font-size: 11px;
              font-weight: 500;
              min-height: 0;
          }

          /* Waybar */
          window#waybar {
              background: linear-gradient(0deg, #${base00} 0%, #${base02} 66%);
              padding-bottom: 3px;
              color: #${base07};
              border-radius: 0;
              opacity: 0.9;
          }

          #window {
              padding-left: 10px;
              padding-right: 10px;
              color: #${base06};
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
              background: linear-gradient(0deg, #${base07} 0%, #${base0C} 66%);
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


          #clock.date,
          #clock,
          #network,
          #wireplumber,
          #custom-battery,
          #bluetooth,
          #tray {
            padding: 0 10px;
            margin: 6px 2px;
            color: #${base07};
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
