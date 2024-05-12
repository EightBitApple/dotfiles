{ config, lib, pkgs, inputs, userSettings, ... }:

{
  options.textEditors.enable = lib.mkEnableOption ''
    Install text editors.
  '';

  config = lib.mkIf config.textEditors.enable {
    programs.emacs = {
      enable = true;
      package = userSettings.emacsPkg;
      extraPackages = epkgs: [ epkgs.vterm ];
    };
    programs.neovim.enable = true;
  };
}
