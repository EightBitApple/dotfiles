{ pkgs, ... }:

{
  home.packages = with pkgs; [ ironwail ];
}
