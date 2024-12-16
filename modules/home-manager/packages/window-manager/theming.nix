{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Obsidian-Green";
      package = pkgs.iconpack-obsidian;
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
