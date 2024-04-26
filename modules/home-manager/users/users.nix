{ config, lib, pkgs, ... }:

{
  options.users.enable = lib.mkEnableOption ''
    Give Home Manager information about the paths in should manage.
  '';

  config = lib.mkIf config.users.enable {
    home = {
      username = "stefan";
      homeDirectory = "/home/stefan";
    };
  };
}
