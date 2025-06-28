{ pkgs, ... }:

{
  home.packages = with pkgs; [
    keepassxc
    nixos-firewall-tool
  ];
}
