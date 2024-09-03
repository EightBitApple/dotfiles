{
  config,
  lib,
  pkgs-stable,
  ...
}:

{
  options.hyprland.enable = lib.mkEnableOption ''
    Enable the use of the Hyprland Wayland compositor.
  '';

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      portalPackage = pkgs-stable.xdg-desktop-portal-hyprland;
    };
  };
}
