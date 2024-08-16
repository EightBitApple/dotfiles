{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pam.enable = lib.mkEnableOption ''
    Enable and configure PAM.
  '';

  config = lib.mkIf config.pam.enable { security.pam.services.hyprlock = { }; };
}
