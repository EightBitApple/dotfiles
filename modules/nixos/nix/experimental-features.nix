{ config, lib, ... }:

{
  # Enable Nix's experimental features, such as new nix* commands and flakes.

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
