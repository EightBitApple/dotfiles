{ lib, ... }:

{
  programs.alacritty.settings.window.opacity = lib.mkForce 0.90;
}
