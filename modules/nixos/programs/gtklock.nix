{ pkgs, ... }:

let
  batTooltip = pkgs.writeShellApplication {
    name = "bat-tooltip";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      battery-status | jq -r '.tooltip'
    '';
  };
in

{
  programs.gtklock = {
    enable = true;

    config = {
      main = {
        follow-focus = true;
        idle-hide = true;
        idle-timeout = 10;
      };
      runshell = {
        command = "bash -c ${batTooltip}/bin/bat-tooltip";
        refresh = 15;
        runshell-position = "bottom-center";
        justify = "center";
        margin-bottom = 20;
      };
    };

    modules = with pkgs; [
      gtklock-powerbar-module
      myPackages.gtklock-runshell-module
    ];

    style =
      let
        readStyle = file: builtins.readFile ../../home-manager/resources/stylings/${file}.css;
      in
      ''
        ${readStyle "text"}

        * { font-family: DejaVu Sans; }

        window {
          background-image: url("/home/stefan/.local/share/current-wallpaper-lockscreen");
          background-size: cover;
          background-repeat: no-repeat;
          background-position: center;
          background-color: @text_color
        }

        #clock-label, #date-label {
          font-weight: 300;
          font-size: 72px;
          color: @text_color_white;

          padding: 0.25em;
          padding: 10px;
          margin: 8px;

          ${readStyle "aero-glass"}
          ${readStyle "highlights"}
        }

        #clock-label {
          font-size: 72px;
          margin-bottom: 10px;
        }

        #date-label {
          font-size: 48px;
          margin-bottom: 150px;
        }

        #runshell {
          font-size: 14px;
          color: white;
          text-shadow: 1px 1px 2px black;
        }

        #input-label, #error-label {
          font-size: 0px;
        }

        #input-field {
          font-size: 16px;
        }
      '';
  };
}
