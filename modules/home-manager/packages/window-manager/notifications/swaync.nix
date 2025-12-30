{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      libnotify
      swaynotificationcenter
    ];
    file = {
      ".config/swaync/config.json".source = ./config.json;
      ".config/swaync/style.css".text =
        let
          readStyle = file: builtins.readFile ../../../resources/stylings/${file}.css;
        in
        ''
          ${readStyle "text"}

          * {
            color: @text_color_white;
            font-weight: 500;
          }

          .summary {
            font-size: 20px;
          }

          .body {
            font-size: 16px;
          }

          .image {
            border-radius: 0px;
            margin-right: 15px;
          }

          .notification, .close-button, .close-button:hover {
            ${readStyle "aero-glass"}
            ${readStyle "highlights"}
          }

          .notification-default-action:hover {
            background: none;
          }
        '';
    };
  };
}
