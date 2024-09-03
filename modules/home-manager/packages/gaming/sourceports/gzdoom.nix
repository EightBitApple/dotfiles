{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.gzdoom.enable = lib.mkEnableOption ''
    Install and configire gzdoom.
  '';

  config = lib.mkIf config.gzdoom.enable {
    home.packages = with pkgs; [ gzdoom ];
  };
}
