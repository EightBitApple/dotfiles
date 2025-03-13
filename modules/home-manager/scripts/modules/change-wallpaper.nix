{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "change-wallpaper";
      runtimeInputs = [
        libnotify
        sxiv
      ];
      text = builtins.readFile ../scripts/change-wallpaper.sh;
    })
  ];
}
