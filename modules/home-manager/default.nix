{ lib, userSettings, ... }:

{
  imports = [
    ./fonts.nix
    ./packages/browsers/librewolf.nix
    ./packages/gaming/emulators.nix
    ./packages/gaming/mangohud.nix
    ./packages/gaming/sourceports/dsda-doom.nix
    ./packages/gaming/sourceports/gzdoom.nix
    ./packages/gaming/sourceports/ironwail.nix
    ./packages/media/audio-tools.nix
    ./packages/media/obs-studio.nix
    ./packages/media/video-playback.nix
    ./packages/mime.nix
    ./packages/terminals.nix
    ./packages/text-editors/emacs.nix
    ./packages/text-editors/neovim.nix
    ./packages/utilities/development/direnv.nix
    ./packages/utilities/development/git.nix
    ./packages/utilities/development/virtualisation.nix
    ./packages/utilities/display.nix
    ./packages/utilities/editing/documents.nix
    ./packages/utilities/editing/image.nix
    ./packages/utilities/editing/text.nix
    ./packages/utilities/file-management.nix
    ./packages/utilities/network/email.nix
    ./packages/utilities/network/syncthing.nix
    ./packages/utilities/security.nix
    ./packages/utilities/terminal/fhs.nix
    ./packages/utilities/terminal/misc.nix
    ./packages/utilities/terminal/nix-helpers.nix
    ./packages/utilities/terminal/system-health.nix
    ./packages/utilities/terminal/zsh.nix
    ./packages/window-manager/clipboard.nix
    ./packages/window-manager/hyprland/hypridle.nix
    ./packages/window-manager/hyprland/hyprland.nix
    ./packages/window-manager/hyprland/keybinds/app-shortcuts.nix
    ./packages/window-manager/hyprland/keybinds/media.nix
    ./packages/window-manager/hyprland/keybinds/submaps/airmouse.nix
    ./packages/window-manager/hyprland/keybinds/utilities.nix
    ./packages/window-manager/hyprland/keybinds/window-management.nix
    ./packages/window-manager/launcher/wofi.nix
    ./packages/window-manager/lockscreen/gtklock.nix
    ./packages/window-manager/night-light.nix
    ./packages/window-manager/notifications/swaync.nix
    ./packages/window-manager/taskbar/waybar.nix
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
      EDITOR = "${userSettings.emacs.name}";
      FLAKE = "${userSettings.user.dotfilesDir}";
      NIXOS_OZONE_WL = 1;
    };
  };
}
