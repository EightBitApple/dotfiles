{ pkgs, userSettings, ... }:

{
  home = {
    packages = [ pkgs.gtklock ];
    file.".config/gtklock/style.css".source = ./style.css;
  };
}
