{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "battery-warning";
      text = builtins.readFile ../scripts/battery-warning.sh;
    })
  ];
}
