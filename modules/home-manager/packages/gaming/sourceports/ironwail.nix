{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ ironwail ];
}
