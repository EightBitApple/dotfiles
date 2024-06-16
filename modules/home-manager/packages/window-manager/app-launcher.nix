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
    home.packages = with pkgs; [ tofi ];

    programs.tofi = {
      enable = true;
    };
  };
}
