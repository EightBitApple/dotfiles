{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.appLauncher.enable = lib.mkEnableOption ''
    Install and configure the Tofi application launcher.
  '';

  config = lib.mkIf config.appLauncher.enable {
    programs.tofi = {
      enable = true;
      settings = {
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        font-size = lib.mkForce 24;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 25;
        num-results = 5;
      };
    };
  };
}
