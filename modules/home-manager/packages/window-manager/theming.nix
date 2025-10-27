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
      name = "Windows-Vista";
      package = pkgs.myPackages.windows-vista-theme;
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
