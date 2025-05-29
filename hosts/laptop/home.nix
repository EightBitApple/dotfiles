{
  imports = [
    ../../modules/home-manager
    ../../overlays
    ./home-manager/packages/window-manager/hyprland/hyprland.nix
    ./home-manager/packages/terminals.nix
  ];

  disabledModules = [
    ../../modules/home-manager/packages/gaming/emulators.nix
    ../../modules/home-manager/packages/gaming/mangohud.nix
    ../../modules/home-manager/packages/gaming/sourceports/dsda-doom.nix
    ../../modules/home-manager/packages/gaming/sourceports/gzdoom.nix
    ../../modules/home-manager/packages/gaming/sourceports/ironwail.nix
    ../../modules/home-manager/packages/media/obs-studio.nix
  ];
}
