{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.nixHelpers.enable = lib.mkEnableOption ''
    Install Nix helpers.
  '';

  config = lib.mkIf config.nixHelpers.enable {
    programs.nh = {
      enable = true;
      flake = "${userSettings.dotfilesDir}";
      clean = {
        enable = true;
        extraArgs = "--keep 4";
      };
    };
  };
}
