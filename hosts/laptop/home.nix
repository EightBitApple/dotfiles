{
  config,
  pkgs,
  lib,
  ...
}:

{
  dsda-doom.enable = false;
  gzdoom.enable = false;
  ironwail.enable = false;
  mangohud.enable = false;

  wayland.windowManager.hyprland.settings = {
    decoration = {
      blur.enabled = lib.mkForce false;
      drop_shadow = lib.mkForce false;
    };
    misc.vfr = lib.mkForce true;

    bind = [
      ", XF86MonBrightnessUp, exec, changebrightness up 10"
      ", XF86MonBrightnessDown, exec, changebrightness down 10"
    ];
  };
}
