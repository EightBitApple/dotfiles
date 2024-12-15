{
  config,
  lib,
  systemSettings,
  ...
}:

{
  # Enable Nix store optimisation during system rebuilds.
  nix.settings.auto-optimise-store = true;
}
