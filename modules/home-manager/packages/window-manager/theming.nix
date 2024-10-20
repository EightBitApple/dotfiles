{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.theming.enable = lib.mkEnableOption ''
    Install and confgure gtk and qt themes.
  '';

  config = lib.mkIf config.theming.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Obsidian-Mint";
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
  };
}
