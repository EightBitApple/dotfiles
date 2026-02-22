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
          "niri/workspaces"
        ];

        modules-right = [
          "niri/window"
          "niri/submap"
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

        "niri/workspaces" = {
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

        "niri/window" = {
          icon = true;
          rotate = 90;
          max-length = 102;
        };
      };
    };
    style =
      let
        readStyle = file: builtins.readFile ../../resources/stylings/${file}.css;
      in
      ''
        ${readStyle "text"}

        * {
          border: none;
          font-family: DejaVu Sans;
          font-size: 14px;
        }

        window#waybar, #tray menuitem {
          ${readStyle "aero-glass"}
          margin: 4px;
          padding: 4px 8px;

          border: 1px solid #757575;
          border-left: none;
          border-radius: 8px;
          border-top-left-radius: 0px;
          border-bottom-left-radius: 0px;

          color: @text_color_white;
        }

        #window { padding-bottom: 5px; }

        #custom-battery,
        #custom-idle,
        #clock,
        #bluetooth,
        #wireplumber,
        #tray,
        #submap,
        tooltip,
        #tray menu,
        #tray menuitem:hover,
        #workspaces button,
        #workspaces button.active,
        #workspaces button:hover {
          color: @text_color;
          border-radius: 8px;
          margin: 4px;
          padding: 4px 8px;

          ${readStyle "select"}
          ${readStyle "highlights"}
        }

        #tray menu { border-radius: 0px; }

        #tray menuitem, #tray menuitem:hover {
          margin-left: 8px;
          margin-right: 8px;
          border-radius: 8px;
          border: none;
          color: @text_color_white;
        }

        #tray menuitem:hover {
          color: @text_color;
          animation: fadein 0.2s linear;
        }

        tooltip label {
          color: @text_color;
        }

        #custom-idle {
          padding-left: 0.8em;
          padding-right: 1em;
        }

        #workspaces button, #tray menuitem {
          color: @text_color_white;
          background: none;

          margin-left: 10px;
          margin-right: 10px;

          ${readStyle "button"}
        }

        #workspaces button.active, #workspaces button:hover {
          animation: expand 0.2s ease-out;
          border-radius: 8px;

          margin-left: 5px;
          margin-right: 5px;
        }

        #workspaces button.urgent {
          color: @text_color_white;
          animation: blinker 1.5s linear infinite;

          ${readStyle "alert"}
        }

        ${readStyle "animation/blinker"}
        ${readStyle "animation/expand"}
      '';
  };
}
