{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.theming.enable = lib.mkEnableOption ''
    Install and confgure gtk and qt themes.
  '';

  config = lib.mkIf config.theming.enable {
    stylix = {
      enable = true;
      image = userSettings.wallpaper;
      cursor.package = pkgs.bibata-cursors;
      cursor.name = "Bibata-Modern-Ice";
      polarity = "dark"; # "light" or "either"
    };

    stylix.fonts = with userSettings; {
      monospace = {
        name = monospaceFont;
        package = monospaceFontPkg;
      };

      sansSerif = {
        name = sansSerifFont;
        package = sansSerifFontPkg;
      };

      serif = {
        name = serifFont;
        package = serifFontPkg;
      };

      sizes = {
        applications = 12;
        terminal = 11;
        desktop = 10;
        popups = 12;
      };
    };

    stylix.opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 0.9;
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
    qt.enable = true;
  };
}
