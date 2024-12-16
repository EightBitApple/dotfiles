{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "changebrightness";
      runtimeInputs = [
        brillo
        libnotify
      ];
      text = builtins.readFile ../scripts/change-brightness.sh;
    })
  ];
}
