{ config, lib, pkgs, pkgs-unstable, inputs, userSettings, ... }:

{
  options.textEditors.enable = lib.mkEnableOption ''
    Install text editors.
  '';

  config = lib.mkIf config.textEditors.enable {
    programs.emacs = {
      enable = true;
      package = userSettings.emacsPkg;
    };
    programs.neovim.enable = true;
  };
}
