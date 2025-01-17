{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vrrtest
    wdisplays
    swaybg
  ];
}
