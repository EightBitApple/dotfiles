{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "emacs";
    FLAKE = ".dotfiles";
  };
  syncthing.enable = true;
}
