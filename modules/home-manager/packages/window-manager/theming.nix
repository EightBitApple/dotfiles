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
      image = userSettings.wallpaperDay;

      # scheme: "Tomorrow Night"
      # author: "Chris Kempson (http://chriskempson.com)"
      base16Scheme = {
        base00 = "1d1f21";
        base01 = "282a2e";
        base02 = "373b41";
        base03 = "969896";
        base04 = "b4b7b4";
        base05 = "c5c8c6";
        base06 = "e0e0e0";
        base07 = "ffffff";
        base08 = "cc6666";
        base09 = "de935f";
        base0A = "f0c674";
        base0B = "b5bd68";
        base0C = "8abeb7";
        base0D = "81a2be";
        base0E = "b294bb";
        base0F = "a3685a";
      };

      cursor.package = pkgs.bibata-cursors;
      cursor.name = "Bibata-Modern-Ice";
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
        terminal = 10;
        desktop = 10;
        popups = 12;
      };
    };

    stylix.opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 0.95;
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
