{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "img-edit";
      runtimeInputs = [
        swappy
        wl-clipboard
      ];
      text = ''
        wl-paste | swappy -f -;
      '';
    })
  ];
}
