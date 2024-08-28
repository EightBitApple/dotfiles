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
      image = userSettings.wallpaperNeutral;

      # scheme: "Catppuccin Mocha"
      # author: "https://github.com/catppuccin/catppuccin"
      base16Scheme = {
        base00 = "1e1e2e"; # base
        base01 = "181825"; # mantle
        base02 = "313244"; # surface0
        base03 = "45475a"; # surface1
        base04 = "585b70"; # surface2
        base05 = "cdd6f4"; # text
        base06 = "f5e0dc"; # rosewater
        base07 = "b4befe"; # lavender
        base08 = "f38ba8"; # red
        base09 = "fab387"; # peach
        base0A = "f9e2af"; # yellow
        base0B = "a6e3a1"; # green
        base0C = "94e2d5"; # teal
        base0D = "89b4fa"; # blue
        base0E = "cba6f7"; # mauve
        base0F = "f2cdcd"; # flamingo
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
      terminal = 0.9;
      desktop = 1.0;
      popups = 0.9;
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Obsidian";
        package = pkgs.iconpack-obsidian;
      };
    };
    qt.enable = true;
  };
}
