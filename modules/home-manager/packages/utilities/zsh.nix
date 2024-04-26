{ config, lib, pkgs, ... }:

{
  options.zsh.enable = lib.mkEnableOption ''
    Install configure zsh.
  '';

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      envExtra = ''
        path=('/usr/local/bin' $path)
        path+=('/home/stefan/.local/bin')
        path+=('/home/stefan/.local/bin/arkenfox')
        path+=('/home/stefan/dotnet/tools')
        path+=('/home/stefan/.config/emacs/bin')
        export PATH
      '';
    };
  };
}
