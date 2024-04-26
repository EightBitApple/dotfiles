{ config, lib, pkgs, ... }:

{
  options.syncthing.enable = lib.mkEnableOption ''
    Install and configure Syncthing.
  '';

  config = lib.mkIf config.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
        tray = true;
      };
    };
  };
}
