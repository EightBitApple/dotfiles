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
      name = "crystal-remix-icon-theme-diinki-version";
      package = pkgs.myPackages.diinki-aero;
    };
    theme = {
      name = "diinki-aero";
      package = pkgs.myPackages.diinki-aero;
    };
  };
  qt.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = userSettings.windowManager.cursorSize;
    gtk.enable = true;
  };
}
