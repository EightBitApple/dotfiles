{ pkgs, ... }:

{
  home.packages = with pkgs; [
    file-roller
    zip
    mate.caja
  ];
}
