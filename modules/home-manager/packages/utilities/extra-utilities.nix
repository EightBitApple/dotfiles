{ pkgs, ... }:

{
  home.packages = with pkgs; [
    keepassxc
    fastfetch
    vrrtest
    nix-output-monitor
    nvd
    gimp
    aspell
    aspellDicts.en
    imagemagick
    thunderbird
    texliveFull
    unzip
    libreoffice
    lm_sensors
    appimage-run
    file-roller
    home-manager
    kdePackages.okular
    tldr
  ];
}
