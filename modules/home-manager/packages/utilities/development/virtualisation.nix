{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickemu
    dive           # look into docker image layers
    podman-tui     # status of containers in the terminal
    podman-compose # start group of containers for dev
    distrobox      # use any linux distro in your terminal
  ];
}
