{ pkgs, lib, ... }:

let
  toggleLaptopDisplay = pkgs.writeShellApplication {
    name = "toggle-display";
    runtimeInputs = with pkgs; [
      jq
      dunst
    ];
    text = ''
      display_json=$(hyprctl -j monitors)

      sleep_delay=1
      notif_time=2000

      # Get monitor info as JSON and parse it.
      laptop_display=$(printf "%s" "$display_json" | jq '.[] | select(.id == 0)')
      display_status=$(printf "%s" "$laptop_display" | jq '.dpmsStatus')
      display_name=$(printf "%s" "$laptop_display" | jq -r '.name')

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
  imports = [
    ../../modules/home-manager
    ../../overlays
  ];

  disabledModules = [
    ../../modules/home-manager/packages/gaming/sourceports/dsda-doom.nix
    ../../modules/home-manager/packages/gaming/sourceports/gzdoom.nix
    ../../modules/home-manager/packages/gaming/sourceports/ironwail.nix
    ../../modules/home-manager/packages/gaming/mangohud.nix
  ];

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
  };
}
