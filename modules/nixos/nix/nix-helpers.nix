{ userSettings, ... }:

{
  # Install Nix helpers.

  programs.nh = {
    enable = true;
    flake = "${userSettings.dotfilesDir}";
    clean = {
      enable = true;
      extraArgs = "--keep 4";
    };
  };
}
