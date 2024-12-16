{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    pulsemixer
    pamixer
    qpwgraph
    schismtracker
  ];
}
