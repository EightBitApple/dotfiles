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
      text = ''
        grim -g "$(slurp)" - | convert - -shave 1x1 PNG:- | wl-copy
      '';
    })
  ];
}
