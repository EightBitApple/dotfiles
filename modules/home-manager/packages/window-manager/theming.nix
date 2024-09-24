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
