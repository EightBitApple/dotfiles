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
          colors = with config.colorScheme.palette; {
            alpha = "0.90";
            background = "${base00}";
            foreground = "${base07}";
          };
        };
      };
    };
  };
}
