{ config, lib, ... }:

{
  options.home-manager.enable = lib.mkEnableOption ''
    Enable home-manager to configure itself.
  '';
  config = lib.mkIf config.home-manager.enable { home-manager.enable = true; };
}
