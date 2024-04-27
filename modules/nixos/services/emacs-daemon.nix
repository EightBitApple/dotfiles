{ config, lib, pkgs, userSettings, ... }:

{
  options.emacsDaemon.enable = lib.mkEnableOption ''
    Enable the emacs daemon as a SystemD service.
  '';

  config = lib.mkIf config.emacsDaemon.enable {
    services.emacs = {
      enable = true;
      package = userSettings.emacsPkg;
    };
  };
}
