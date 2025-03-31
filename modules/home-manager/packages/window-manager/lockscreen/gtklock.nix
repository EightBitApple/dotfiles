{ pkgs, userSettings, ... }:

{
  home = {
    packages = [ pkgs.gtklock ];
    file.".config/gtklock/style.css".source = ./style.css;
    file.".config/gtklock/vista.png".source = userSettings.windowManager.wallpaper;
  };
}
