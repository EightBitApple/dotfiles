{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dsda-doom
    dsda-launcher
  ];
}
