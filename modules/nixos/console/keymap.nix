{ config, lib, ... }:

{
  options.keymap.enable = lib.mkEnableOption ''
    Set keymap for the console (TTY).
  '';

  config = lib.mkIf config.keymap.enable { console.keyMap = "uk"; };
}
