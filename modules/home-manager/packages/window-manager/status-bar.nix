{
  config,
  systemSettings,
  userSettings,
  ...
}:

{
  programs.waybar = {
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
          "hyprland/submap"
          "wireplumber"
          "custom/battery"
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
          interval = 15;
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
      @keyframes blink {
          to {
            background: linear-gradient(
              to bottom,
              #373737 0%,
              #232323 50%,
              #0f0f0f 51%,
              #0f0f0f 100%
            );
            color: #f5f5f5;
          }
      }

      * {
          font-family: ${userSettings.monospaceFont};
          font-size: 11px;
          font-weight: 500;
          min-height: 0;
      }

      window#waybar {
        background: linear-gradient(
          to bottom,
          #373737 0%,
          #232323 50%,
          #0f0f0f 51%,
          #0f0f0f 100%
        );
        border-top: 2px solid #5e5d5d;
        border-left: 1.5px solid #5a5a5a;
        border-bottom: 3px solid #020202;
        border-right: 1.5px solid #5a5a5a;
        padding: 1px 5px 4px 5px;
        margin: 0px;
        font-weight: normal;
      }

      #window {
        padding-left: 10px;
        padding-right: 10px;
        color: #${base06};
      }

      #workspaces button {
        color: #${base06};
        padding: 1px 0px 3px 0px;
        margin-top: 2px;
        margin-bottom: 2px;
        margin-left: 2px;
      }

      #workspaces button.active {
        background: linear-gradient(
          to bottom,
          #f1f4fa 0%,
          #dbe0f0 50%,
          #a4b2db 51%,
          #a4b2db 100%
        );
        color: #${base00};
      }

      #workspaces button.urgent {
        background: linear-gradient(
          to bottom,
          #ffdd33 0%,
          #ffd500 50%,
          #ffaa22 51%,
          #ffaa22 100%
        );
        color: #${base00};

        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      tooltip {
        color: #${base07};
        background: linear-gradient(
            to bottom,
            #373737 0%,
            #232323 50%,
            #161616 51%,
            #161616 100%
        );
        border-top: 1.5px solid #585858;
        border-left: 1.5px solid #3a3a3a;
        border-bottom: 2.5px solid #0e0e0e;
        border-right: 1.5px solid #3a3a3a;
        border-radius: 3px;
        color: #f7f4f4;
      }

      #clock.date,
      #clock,
      #network,
      #wireplumber,
      #custom-battery,
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
}
