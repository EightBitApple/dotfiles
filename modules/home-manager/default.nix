{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./fonts.nix
    ./users/users.nix

    ./packages/text-editors/text-editors.nix
    ./packages/browsers/firefox.nix
    ./packages/terminals.nix
    ./packages/programming-tools.nix

    ./packages/media/video-playback.nix
    ./packages/media/audio-tools.nix

    ./packages/window-manager/waybar/waybar.nix

    ./packages/window-manager/app-launcher.nix
    ./packages/window-manager/dunst/dunst.nix
    ./packages/window-manager/clipboard.nix
    ./packages/window-manager/night-light.nix
    ./packages/window-manager/theming.nix

    ./packages/window-manager/hypr/hyprpaper.nix
    ./packages/window-manager/hypr/hyprland.nix

    ./packages/utilities/extra-utilities.nix
    ./packages/utilities/git.nix
    ./packages/utilities/home-manager.nix
    ./packages/utilities/htop.nix
    ./packages/utilities/zsh.nix
    ./packages/utilities/syncthing.nix

    ./packages/gaming/sourceports/dsda-doom.nix
    ./packages/gaming/sourceports/gzdoom.nix
    ./packages/gaming/sourceports/ironwail.nix

    ./packages/gaming/mangohud.nix

    ./scripts/scripts.nix
    ./resources/resources.nix
    ./resources/xresources.nix
  ];

  fonts.enable = lib.mkDefault true;
  users.enable = lib.mkDefault true;

  textEditors.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  terminals.enable = lib.mkDefault true;
  programmingTools.enable = lib.mkDefault true;

  videoPlayback.enable = lib.mkDefault true;
  audioTools.enable = lib.mkDefault true;

  waybar.enable = lib.mkDefault true;

  appLauncher.enable = lib.mkDefault true;
  dunst.enable = lib.mkDefault true;
  clipboard.enable = lib.mkDefault true;
  nightLight.enable = lib.mkDefault true;
  theming.enable = lib.mkDefault true;

  hyprpaper.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;

  extra-utilities.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  home-manager.enable = lib.mkDefault true;
  htop.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault false;

  dsda-doom.enable = lib.mkDefault true;
  gzdoom.enable = lib.mkDefault true;
  ironwail.enable = lib.mkDefault true;

  mangohud.enable = lib.mkDefault true;

  scripts.enable = lib.mkDefault true;
  resources.enable = lib.mkDefault true;
  xresources.enable = lib.mkDefault true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home.sessionVariables = {
    EDITOR = "emacs";
    FLAKE = ".dotfiles";
  };
}
