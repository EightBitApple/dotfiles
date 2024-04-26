{ config, lib, pkgs, ... }:

{
  options.groups.enable = lib.mkEnableOption ''
    Define custom user groups.
  '';

  config = lib.mkIf config.groups.enable {
    users.groups.wireshark = { };
    users.groups.gamemode = { };
  };
}
