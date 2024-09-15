{ lib, ... }:

{
  imports = [
    ./fonts.nix
    ./packages/browsers/firefox.nix
    ./packages/gaming/mangohud.nix
    ./packages/gaming/sourceports/dsda-doom.nix
    ./packages/gaming/sourceports/gzdoom.nix
    ./packages/gaming/sourceports/ironwail.nix
    ./packages/media/audio-tools.nix
    ./packages/media/video-playback.nix
    ./packages/mime.nix
    ./packages/terminals.nix
    ./packages/text-editors/emacs.nix
    ./packages/text-editors/neovim.nix
    ./packages/utilities/extra-utilities.nix
    ./packages/utilities/git.nix
    ./packages/utilities/home-manager.nix
    ./packages/utilities/htop.nix
    ./packages/utilities/syncthing.nix
    ./packages/utilities/zsh.nix
    ./packages/window-manager/app-launcher.nix
    ./packages/window-manager/clipboard.nix
    ./packages/window-manager/dunst/dunst.nix
    ./packages/window-manager/hypr/hypridle.nix
    ./packages/window-manager/hypr/hyprland.nix
    ./packages/window-manager/hypr/hyprlock.nix
    ./packages/window-manager/hypr/hyprpaper.nix
    ./packages/window-manager/night-light.nix
    ./packages/window-manager/theming.nix
    ./packages/window-manager/waybar/waybar.nix
    ./packages/xdg-user-dirs.nix
    ./resources/resources.nix
    ./scripts/scripts.nix
    ./users/users.nix
  ];

  appLauncher.enable = lib.mkDefault true;
  audioTools.enable = lib.mkDefault true;
  clipboard.enable = lib.mkDefault true;
  emacs.enable = lib.mkDefault true;
  dsda-doom.enable = lib.mkDefault true;
  dunst.enable = lib.mkDefault true;
  extra-utilities.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  fonts.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  gzdoom.enable = lib.mkDefault true;
  home-manager.enable = lib.mkDefault true;
  htop.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  hyprpaper.enable = lib.mkDefault true;
  ironwail.enable = lib.mkDefault true;
  mangohud.enable = lib.mkDefault true;
  mime.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  nightLight.enable = lib.mkDefault true;
  resources.enable = lib.mkDefault true;
  scripts.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault true;
  terminals.enable = lib.mkDefault true;
  theming.enable = lib.mkDefault true;
  users.enable = lib.mkDefault true;
  videoPlayback.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
  xdgUserDirs.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;

  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.
    sessionVariables = {
      EDITOR = "emacs";
      FLAKE = ".dotfiles";
    };
  };
}
