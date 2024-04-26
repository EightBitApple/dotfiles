{ config, lib, pkgs, ... }:

{
  options.printing.enable = lib.mkEnableOption ''
    Enable printing using CUPS.
  '';

  config = lib.mkIf config.printing.enable { services.printing.enable = true; };
}
