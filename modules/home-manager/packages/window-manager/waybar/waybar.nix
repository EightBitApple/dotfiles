{ config, lib, pkgs, ... }:

{
  options.waybar.enable = lib.mkEnableOption ''
    Install and configure Waybar.
  '';

  config = lib.mkIf config.waybar.enable {
    programs = {
      waybar = {
        enable = true;
        settings = {

          mainBar = {
            output = [ "DP-1" "HDMI-A-1" ];
            layer = "top";
            position = "left";
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window#vert" ];
            modules-right = [
              "wireplumber"
              "custom/battery"
              "network"
              "clock#date"
              "clock"
              "tray"
            ];

            "tray" = {
              icon-size = 21;
              spacing = 10;
            };

            "clock" = {
              format = ''
                {:%H
                %M}'';
              timezone = "Europe/London";
            };

            "clock#date" = {
              format = ''
                {:%a
                %b
                %d}'';
              timezone = "Europe/London";
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
            };

            "network" = {
              format-wifi = ''
                WLS
                {signalStrength}'';
              format-ethernet = "ETH";
              tooltip-format = ''
                {ifname}	{ipaddr}/{cidr}
                gateway	{gwaddr}
                	{essid}
                {icon}  ⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}'';
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "DC";
              on-click = "footclient -e nmtui";
            };

            "custom/battery" = {
              format = "{}";
              exec = "~/.local/bin/custom-bar-modules/bm-battery";
              interval = 60;
              signal = 10;
              return-type = "json";
            };

            "hyprland/workspaces" = {
              format = "{}";
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
              on-click = "activate";
            };

            "hyprland/window#vert" = {
              max-length = 64;
              rotate = 90;
            };

            "wireplumber" = {
              format = ''
                VOL
                {volume}'';
              on-click = "footclient pulsemixer";
            };
          };

          secondaryBar = {
            output = [ "DP-2" ];
            layer = "top";
            position = "bottom";
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [
              "wireplumber"
              "custom/battery"
              "network"
              "clock#date"
              "clock"
              "tray"
            ];
            "tray" = {
              icon-size = 21;
              spacing = 10;
            };

            "clock" = {
              format = "{:%H:%M}";
              timezone = "Europe/London";
            };

            "clock#date" = {
              format = "{:%a %b %d}";
              timezone = "Europe/London";
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
            };

            "network" = {
              format-wifi = "WLS {signalStrength}";
              format-ethernet = "ETH";
              tooltip-format = ''
                {ifname}	{ipaddr}/{cidr}
                gateway	{gwaddr}
                	{essid}
                {icon}  ⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}'';
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "DC";
              on-click = "footclient -e nmtui";
            };

            "custom/battery" = {
              format = "{}";
              exec = "~/.local/bin/custom-bar-modules/bm-battery";
              interval = 60;
              signal = 10;
              return-type = "json";
            };

            "hyprland/workspaces" = {
              format = "{}";
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
              on-click = "activate";
            };

            "hyprland/window" = { max-length = 64; };

            "wireplumber" = {
              format = "VOL {volume}";
              on-click = "footclient pulsemixer";
            };
          };
        };
        style = with config.colorScheme.palette; ''
          * {
              /* `otf-font-awesome` is required to be installed for icons */
              font-family: FiraCode Nerd Font;
              font-weight: 500;
              font-size: 11px;
          }

          /* Waybar */
          window#waybar {
              background-color: transparent;
          }

          /* Window Title */
          #window {
              color: #${base07};
              margin: 0.5em;
              padding: 0.5em;
          }

          window#waybar.empty .modules-center {
              background-color: transparent;
              border-width: 0;
          }

          .modules-center {
              margin: 0.5em;
              background-color: #${base00};
              border-radius: 0.5em;
              box-shadow: 2px 2px #${base07};
          }

          window#waybar.empty .modules-center {
              background-color: transparent;
              border-width: 0;
              box-shadow: none;
          }

          #workspaces button {
              margin: 0.25em 0.5em;
              padding: 0.25em 0.5em;
              color: #${base07};
              background-color: #${base00};
              border-radius: 0.5em;
              box-shadow: 2px 2px #${base07};
          }

          #workspaces#vert button {
              margin: 0.5em 0.25em;
              padding: 0.5em 0.25em;
          }

          #workspaces button:hover {
              background-color: #${base03};
              color: #${base06};
          }

          #workspaces button.active {
              color: #${base00};
              background-color: #${base07};
              box-shadow: 2px 2px #${base00};
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

          #battery, #battery.plugged {
              color: #${base0D};
          }

          #battery.charging, #battery.plugged {
              color: #${base0B};
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          #battery.critical:not(.charging) {
              color: #${base08};
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          #clock.date,
          #clock,
          #network,
          #wireplumber,
          #custom-battery,
          #tray {
              margin: 0.25em 0.5em;
              padding: 0.25em 0.5em;
              background-color: #${base04};
              color: #${base00};
              border-radius: 0.5em;
              box-shadow: 2px 2px #${base00};
          }

          #tray {
              background-color: #${base00};
              box-shadow: 2px 2px #${base07};
              padding: 0.5em;
          }

          #wireplumber.muted,
          #network.disconnected {
              background-color: #${base03};
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
