{ config, lib, pkgs, ... }:

{
  options.thunar.enable = lib.mkEnableOption ''
    Enable the use of Thunar. XFCE's file manager. Along with its archive and
    volume manager.
  '';

  config = lib.mkIf config.thunar.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
      };
      xfconf.enable = true;
    };
  };
}
