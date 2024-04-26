{ config, lib, pkgs, ... }:

{
  options.fonts.enable = lib.mkEnableOption ''
    Install fonts.
  '';

  config = lib.mkIf config.fonts.enable {
    home.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  };
}
