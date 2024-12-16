{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "battery-info";
      text = builtins.readFile ../scripts/battery-info.sh;
    })
  ];
}
