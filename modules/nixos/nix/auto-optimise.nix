{
  config,
  lib,
  systemSettings,
  ...
}:

{
  options.autoOptimise.enable = lib.mkEnableOption ''
    Enable Nix store optimisation during system rebuilds.
  '';

  config = lib.mkIf config.autoOptimise.enable {
    nix.settings.auto-optimise-store = true;
  };
}
