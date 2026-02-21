{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Oxylite";
      package = pkgs.myPackages.oxylite-icon-theme;
    };
    theme = {
      name = "Diinki-Aero";
      package = pkgs.myPackages.diinki-aero;
    };
  };
  qt.enable = true;

  home.pointerCursor = {
    name = "ModernXP";
    package = pkgs.myPackages.modern-xp-cursor-theme;
    size = userSettings.windowManager.cursorSize;
    gtk.enable = true;
  };
}
