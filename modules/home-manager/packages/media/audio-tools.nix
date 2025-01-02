{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulsemixer
    pamixer
    qpwgraph
  ];
}
