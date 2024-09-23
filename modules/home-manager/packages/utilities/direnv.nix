{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.direnv.enable = lib.mkEnableOption ''
    Enable the use direnv automatically enter dev environments.
  '';
  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
