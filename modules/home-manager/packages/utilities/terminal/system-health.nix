{ pkgs, ... }:

{
  programs.htop.enable = true;

  home.packages = with pkgs; [
    fastfetch
    lm_sensors
  ];
}
