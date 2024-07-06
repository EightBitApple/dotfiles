{
  config,
  pkgs,
  lib,
  ...
}:

let
  toggleLaptopDisplay = pkgs.writeShellApplication {
    name = "toggle-display";
    runtimeInputs = with pkgs; [
      jq
      dunst
    ];
    text = ''
      display_json=$(hyprctl -j monitors | jq '.[0]')

      sleep_delay=1
      notif_time=2000

      # Get monitor info as JSON and parse it.
      display_status=$(printf "%s" "$display_json" | jq '.dpmsStatus')
      display_name=$(printf "%s" "$display_json" | jq -r '.name')

      new_status=""
      [ "$display_status" = "true" ] && new_status="off" || new_status="on"

      # Turn display on or off based on outcome of branch.
      notify-send -t "$notif_time" "Turning $new_status laptop display..."
      sleep "$sleep_delay"
      hyprctl dispatch dpms "$new_status" "$display_name"
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
