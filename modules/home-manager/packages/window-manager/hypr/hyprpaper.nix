{ config, lib, pkgs, ... }:

{
  options.hyprpaper.enable = lib.mkEnableOption ''
    Install hyprpaper to set wallpapers in Hyprland.
  '';

  config = lib.mkIf config.hyprpaper.enable {
    home.packages = with pkgs; [ hyprpaper ];

    home.file.".config/hypr/hyprpaper.conf".text = ''
      preload=~/.local/share/active-wallpaper.jpg
      wallpaper = DP-1,~/.local/share/active-wallpaper.jpg
      wallpaper = DP-2,~/.local/share/active-wallpaper.jpg

      splash = false
    '';
  };
}
