{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "screenshot";
      runtimeInputs = [
        grim
        slurp
        imagemagick
        wl-clipboard
      ];
      text = builtins.readFile ../scripts/screenshot.sh;
    })
  ];
}
