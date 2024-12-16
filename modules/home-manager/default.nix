{ lib, userSettings, ... }:

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
    ./packages/utilities/direnv.nix
    ./packages/utilities/extra-utilities.nix
    ./packages/utilities/git.nix
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
    ./packages/window-manager/status-bar.nix
    ./packages/window-manager/theming.nix
    ./packages/xdg-user-dirs.nix
    ./resources/resources.nix
    ./scripts/default.nix
    ./users/users.nix
  ];

  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = "${userSettings.editor}";
      FLAKE = "${userSettings.dotfilesDir}";
    };
  };
}
