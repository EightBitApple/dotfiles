{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.terminals.enable = lib.mkEnableOption ''
    Install terminals.
  '';

  config = lib.mkIf config.terminals.enable {
    programs = {
      foot = {
        enable = true;
        settings = {
          main = {
            pad = "5x5";
          };
        };
      };
    };
  };
}
