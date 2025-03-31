{ userSettings, ... }:

{
  # Install Nix helpers.

  programs.nh = {
    enable = true;
    flake = "${userSettings.user.dotfilesDir}";
    clean = {
      enable = true;
      extraArgs = "--keep 4";
    };
  };
}
