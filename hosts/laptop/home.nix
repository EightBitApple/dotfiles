{ config, pkgs, lib, ... }:

{
  dsda-doom.enable = false;
  gzdoom.enable = false;
  ironwail.enable = false;
  mangohud.enable = false;

  hyprlandDisplay1 = "eDP-1";
  hyprlandDisplay2 = "N/A";
  hyprlandDisplay3 = "N/A";

  waybarDisplay1 = "eDP-1";
  waybarDisplay2 = "N/A";
  waybarDisplay3 = "N/A";

  wayland.windowManager.hyprland.settings = {
    decoration = {
      blur.enabled = lib.mkForce false;
      drop_shadow = lib.mkForce false;
    };
    misc.vfr = lib.mkForce true;
  };
}
