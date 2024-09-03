{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.dsda-doom.enable = lib.mkEnableOption ''
    Install and configure dsda-doom.
  '';

  config = lib.mkIf config.dsda-doom.enable {
    home.packages = with pkgs; [
      dsda-doom
      dsda-launcher
    ];
  };
}
