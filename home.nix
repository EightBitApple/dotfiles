{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "emacs";
    FLAKE = "/home/stefan/.dotfiles";
  };
  syncthing.enable = true;
}
