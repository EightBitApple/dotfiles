{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.fonts.enable = lib.mkEnableOption ''
    Install fonts.
  '';

  config = lib.mkIf config.fonts.enable {
    home.packages = [ userSettings.monospaceFontPkg ];
  };
}
