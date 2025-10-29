{ pkgs, ... }:

{
  programs.gtklock = {
    enable = true;
    style = builtins.readFile ./style.css;
    modules = with pkgs; [ gtklock-powerbar-module ];
  };
}
