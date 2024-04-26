{ config, lib, pkgs, ... }:

{
  options.theming.enable = lib.mkEnableOption ''
    Install and confgure gtk and qt themes.
  '';

  config = lib.mkIf config.theming.enable {
    home.pointerCursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    qt = { enable = true; };
  };
}
