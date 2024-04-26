{ config, lib, pkgs, ... }:

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
            font = "FiraCode Nerd Font:size=10";
            pad = "5x5";
          };
          colors = with config.colorScheme.colors; {
            alpha = "0.95";
            background = "${base01}";
            foreground = "${base07}";
          };
        };
      };
    };
  };
}
