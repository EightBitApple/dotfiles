{
  pkgs,
  lib,
  config,
  ...
}:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "img-edit";
      runtimeInputs = [
        swappy
        wl-clipboard
      ];
      text = builtins.readFile ../scripts/image-edit.sh;
    })
  ];
}
