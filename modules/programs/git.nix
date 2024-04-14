{ config, lib, pkgs, ... }:

{
  options.git.enable = lib.mkEnableOption ''
    Enable the use of the Git version control system.
  '';

  config = lib.mkIf config.git.enable { programs.git = { enable = true; }; };
}
