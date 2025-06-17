{ pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "ns";
      text = ''
        nix shell nixpkgs#"$1" --command ${userSettings.terminal.shell}
      '';
    })
  ];
}
