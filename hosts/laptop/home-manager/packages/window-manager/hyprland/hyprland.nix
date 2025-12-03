{ lib, pkgs, ... }:

let
  toggleLaptopDisplay = pkgs.writeShellApplication {
    name = "toggle-display";
    runtimeInputs = with pkgs; [
      libnotify
      jq
    ];
    text = ''
      # Get monitor info as JSON and parse it.
      display_json=$(hyprctl -j monitors)

      laptop_display=$(printf "%s" "$display_json" | jq '.[] | select(.id == 0)')
      display_status=$(printf "%s" "$laptop_display" | jq '.dpmsStatus')
      display_name=$(printf "%s" "$laptop_display" | jq -r '.name')

      new_status=""
      [ "$display_status" = "true" ] && new_status="off" || new_status="on"
      hyprctl dispatch dpms "$new_status" "$display_name"
    '';
  };
in

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1, preferred, auto, 1"
      "eDP-1, preferred, auto-right, 1"
    ];

    bind = [
      ", XF86MonBrightnessUp, exec, changebrightness up 10"
      "ALT, XF86MonBrightnessUp, exec, changebrightness up 1"

      ", XF86MonBrightnessDown, exec, changebrightness down 10"
      "ALT, XF86MonBrightnessDown, exec, changebrightness down 1"

      "$mod, O, exec, ${toggleLaptopDisplay}/bin/toggle-display"
    ];

    decoration = {
      shadow.enabled = lib.mkForce false;
      blur.enabled = lib.mkForce false;
    };
    render.new_render_scheduling = true;
  };
}
