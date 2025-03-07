{ pkgs, ... }:

{
  home.packages = with pkgs; [ libnotify swaynotificationcenter ];
  home.file.".config/swaync/style.css".source = ./style.css;
}
