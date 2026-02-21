{ pkgs, ... }:

{
  home = {
    file.".config/niri/config.kdl".source = ./config.kdl;
    packages = with pkgs; [
      xwayland-satellite
      xrdb
    ];
  };
}
