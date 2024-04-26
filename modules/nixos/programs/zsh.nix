{ config, lib, pkgs, ... }:

{
  options.zsh.enable = lib.mkEnableOption ''
    Enable the use of ZSH. It's configuration should be done with Home Manager.
  '';

  config = lib.mkIf config.zsh.enable { programs.zsh.enable = true; };
}
