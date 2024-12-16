{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  home.packages = [ userSettings.monospaceFontPkg ];
}
