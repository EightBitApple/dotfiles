{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "changevolume";
      runtimeInputs = with pkgs; [
        pamixer
        libnotify
        wireplumber
      ];
      text = builtins.readFile ../scripts/change-volume.sh;
    })
  ];
}
