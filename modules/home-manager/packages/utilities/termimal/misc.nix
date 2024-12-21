{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unzip
    tldr
  ];
}
