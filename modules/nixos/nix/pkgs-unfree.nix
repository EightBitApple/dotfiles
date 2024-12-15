{ config, lib, ... }:

{
  # Configure Nixpkgs to allow unfree software.

  nixpkgs.config.allowUnfree = true;
}
