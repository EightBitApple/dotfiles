{ userSettings, ... }:

{
  # Give Home Manager information about the paths in should manage.

  home = {
    username = "${userSettings.username}";
    homeDirectory = "/home/${userSettings.username}";
  };
}
