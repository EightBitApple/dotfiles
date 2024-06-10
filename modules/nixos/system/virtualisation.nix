{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.virtualisation.enable = lib.mkEnableOption ''
    Enable and configure virtualisation software.
  '';

  config = lib.mkIf config.virtualisation.enable { virtualisation.waydroid.enable = true; };
}
