{ pkgs, ... }:

{
  home.packages = with pkgs; [ vrrtest ];
}
