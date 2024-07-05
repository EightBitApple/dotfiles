{
  config,
  pkgs,
  lib,
  ...
}:

let
  toggleLaptopDisplay = pkgs.writeShellApplication {
    name = "toggle-display";
    runtimeInputs = with pkgs; [ jq ];
    text = ''
      display_status=$(hyprctl -j monitors | jq '.[0].dpmsStatus')
      sleep 1

      if [ "$display_status" = "true" ]
      then
        hyprctl dispatch dpms off eDP-1
      else
        hyprctl dispatch dpms on eDP-1
      fi
    '';
  };
in
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

      "$mod, O, exec, ${toggleLaptopDisplay}/bin/toggle-display"
    ];
  };
}
