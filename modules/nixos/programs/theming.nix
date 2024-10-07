{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.theming.enable = lib.mkEnableOption ''
    Install and confgure stylix.
  '';

  config = lib.mkIf config.theming.enable {
    stylix = {
      enable = true;
      image = userSettings.wallpaperNeutral;

      # scheme: "Gruvbox dark, medium"
      # author: "Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)"
      base16Scheme = {
        base00 = "282828"; # ----
        base01 = "3c3836"; # ---
        base02 = "504945"; # --
        base03 = "665c54"; # -
        base04 = "bdae93"; # +
        base05 = "d5c4a1"; # ++
        base06 = "ebdbb2"; # +++
        base07 = "fbf1c7"; # ++++
        base08 = "fb4934"; # red
        base09 = "fe8019"; # orange
        base0A = "fabd2f"; # yellow
        base0B = "b8bb26"; # green
        base0C = "8ec07c"; # aqua/cyan
        base0D = "83a598"; # blue
        base0E = "d3869b"; # purple
        base0F = "d65d0e"; # brown
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = with userSettings; {
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

      opacity = {
        applications = 1.0;
        terminal = 0.95;
        desktop = 1.0;
        popups = 0.95;
      };

      targets.plymouth.logo = userSettings.splashLogo;
    };
  };
}
