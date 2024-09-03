{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.neoVim.enable = lib.mkEnableOption ''
    Install neoVim.
  '';

  config = lib.mkIf config.doomEmacs.enable {
    programs.neovim.enable = true;
  };
}
