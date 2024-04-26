{ config, lib, pkgs, ... }:

{
  options.syncthing.enable = lib.mkEnableOption ''
    Enable syncthing.
  '';

  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = "stefan";
      dataDir = "/home/stefan/Documents";
      configDir = "/home/stefan/.config/syncthing";
    };
  };
}
