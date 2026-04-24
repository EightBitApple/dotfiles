{ pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf-unwrapped
  ];
}
