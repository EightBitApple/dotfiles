{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.terminals.enable = lib.mkEnableOption ''
    Install and configure terminal emulators.
  '';

  config = lib.mkIf config.terminals.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window.padding = {
          x = 4;
          y = 4;
        };
      };
    };
  };
}
