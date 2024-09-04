{ config, lib, ... }:

{
  options.hyprland.enable = lib.mkEnableOption ''
    Enable the use of the Hyprland Wayland compositor.
  '';

  config = lib.mkIf config.hyprland.enable { programs.hyprland.enable = true; };
}
