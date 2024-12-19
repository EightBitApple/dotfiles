{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    imagemagick
  ];
}
