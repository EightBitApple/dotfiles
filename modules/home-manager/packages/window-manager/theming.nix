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
      name = "Obsidian-Green";
      package = pkgs.iconpack-obsidian;
    };
  };
  qt.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = userSettings.cursorSize;
    gtk.enable = true;
  };
}
