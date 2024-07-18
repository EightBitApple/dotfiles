{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.users.enable = lib.mkEnableOption ''
    Give Home Manager information about the paths in should manage.
  '';

  config = lib.mkIf config.users.enable {
    home = {
      username = "${userSettings.username}";
      homeDirectory = "/home/${userSettings.username}";
    };
  };
}
