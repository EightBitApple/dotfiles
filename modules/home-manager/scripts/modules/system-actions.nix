{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "sysact";
      runtimeInputs = [ wofi ];
      text = builtins.readFile ../scripts/system-actions.sh;
    })
  ];
}
