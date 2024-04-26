{ config, lib, pkgs, inputs, ... }:

{
  options.textEditors.enable = lib.mkEnableOption ''
    Install text editors.
  '';

  config = lib.mkIf config.textEditors.enable {
    programs = {
      emacs = {
        enable = true;
        package = pkgs.emacs29-pgtk;
      };
      neovim.enable = true;
    };
  };
}
