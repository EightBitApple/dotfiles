{ pkgs, ... }:

{
  home.packages = with pkgs; [ swaynotificationcenter ];
  home.file.".config/swaync/style.css".source = ./style.css;
}
