{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "sysact";
      runtimeInputs = [ tofi ];
      text = builtins.readFile ../scripts/system-actions.sh;
    })
  ];
}
