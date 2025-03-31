{ userSettings, ... }:

{
  # Give Home Manager information about the paths in should manage.

  home = {
    username = "${userSettings.user.name}";
    homeDirectory = "/home/${userSettings.user.name}";
  };
}
