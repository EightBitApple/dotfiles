{ config, lib, ... }:

{
  options.ly.enable = lib.mkEnableOption ''
    Enable and configure the LY display manager.
  '';

  config = lib.mkIf config.ly.enable { services.displayManager.ly.enable = true; };
}
