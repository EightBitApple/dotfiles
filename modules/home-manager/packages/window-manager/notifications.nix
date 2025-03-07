{ pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [ libnotify swaynotificationcenter ];
}
