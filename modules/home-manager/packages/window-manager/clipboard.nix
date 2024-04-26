{ config, lib, pkgs, ... }:

{
  options.clipboard.enable = lib.mkEnableOption ''
    Install wl-clipboard.
  '';

  config = lib.mkIf config.clipboard.enable {
    home.packages = with pkgs; [ wl-clipboard ];
  };
}
