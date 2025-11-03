{
  imports = [
    ../../modules/home-manager
    ../../overlays
    ./home-manager/packages/window-manager/hyprland/hyprland.nix
  ];

  disabledModules = [
    ../../modules/home-manager/packages/utilities/network/nm-applet.nix
  ];
}
