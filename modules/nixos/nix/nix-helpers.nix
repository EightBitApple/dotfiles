{ userSettings, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${userSettings.user.dotfilesDir}";
  };
}
