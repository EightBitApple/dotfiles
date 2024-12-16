{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "battery-status";
      text = builtins.readFile ../scripts/battery-status.sh;
    })
  ];
}
