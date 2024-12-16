{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  home.packages = with pkgs; [
    dsda-doom
    dsda-launcher
  ];
}
