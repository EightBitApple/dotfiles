{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.firejail.enable = lib.mkEnableOption ''
    Enable and configure firejail.
  '';

  config = lib.mkIf config.firejail.enable {
    programs.firejail = {
      enable = true;
    };
  };
}
