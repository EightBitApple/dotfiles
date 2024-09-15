{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.neovim.enable = lib.mkEnableOption ''
    Install neoVim.
  '';

  config = lib.mkIf config.neovim.enable { programs.neovim.enable = true; };
}
