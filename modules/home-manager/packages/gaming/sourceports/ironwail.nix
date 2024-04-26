{ config, lib, pkgs, ... }:

{
  options.ironwail.enable = lib.mkEnableOption ''
    Install ironwail.
  '';

  config = lib.mkIf config.ironwail.enable {
    home.packages = with pkgs; [ ironwail ];
  };
}
