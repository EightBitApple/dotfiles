{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      libnotify
      swaynotificationcenter
    ];
    file = {
      ".config/swaync/style.css".source = ./style.css;
      ".config/swaync/config.json".source = ./config.json;
    };
  };
}
