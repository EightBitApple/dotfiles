{ config, lib, pkgs, ... }:

{
  options.wireshark.enable = lib.mkEnableOption ''
    Enable the use of Wireshark with the wireshark-qt package.
  '';

  config = lib.mkIf config.wireshark.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };
}
