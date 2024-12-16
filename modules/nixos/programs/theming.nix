{ pkgs, userSettings, ... }:

{
  stylix = {
    enable = true;
    image = userSettings.wallpaperNeutral;

    # system: "base16"
    # name: "Gruber"
    # author: "Patel, Nimai <nimai.m.patel@gmail.com>, colors from www.github.com/rexim/gruber-darker-theme"
    # variant: "dark"
    base16Scheme = {
      base00 = "181818";
      base01 = "453d41";
      base02 = "484848";
      base03 = "52494e";
      base04 = "e4e4ef";
      base05 = "f4f4ff";
      base06 = "f5f5f5";
      base07 = "e4e4ef";
      base08 = "f43841";
      base09 = "c73c3f";
      base0A = "ffdd33";
      base0B = "73c936";
      base0C = "95a99f";
      base0D = "96a6c8";
      base0E = "9e95c7";
      base0F = "cc8c3c";
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
        applications = 10;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 0.95;
    };

    targets = {
      plymouth.enable = false;
      console.enable = false;
    };
  };
}
