{ pkgs, ... }:

{
  # https://discourse.nixos.org/t/missing-man-pages/4680/9
  home.packages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
}
