{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Obsidian-Green";
      package = pkgs.iconpack-obsidian.overrideAttrs (
        final: prev: {
          src = pkgs.fetchFromGitHub {
            owner = "EightBitApple";
            repo = "iconpack-obsidian";
            rev = "b4d3d75724f48a8d1f22a46a52ce324362487ff3";
            sha256 = "7G2XDS49CZgQqbnUADHWyw9Ko8kGuFkFWc0fqHR7xgE=";
          };
        }
      );
    };
  };
  qt.enable = true;

  stylix.targets = {
    waybar.enable = false;
    emacs.enable = false;
    fish.enable = false;
    helix.enable = false;
    vim.enable = false;
    foot.enable = false;
    kitty.enable = false;
    tmux.enable = false;
  };
}
