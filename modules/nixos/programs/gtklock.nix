{ pkgs, ... }:

{
  programs.gtklock = {
    enable = true;

    config.main = {
      follow-focus = true;
      idle-hide = true;
      idle-timeout = 10;
    };

    modules = with pkgs; [ gtklock-powerbar-module ];

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

        #clock-label, #date-label, #input-field {
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

        #input-label, #error-label {
          font-size: 0px;
        }

        #input-field {
          font-size: 16px;
          border-radius: 8px;
          color: @text_color;

          ${readStyle "select"}
        }
      '';
  };
}
