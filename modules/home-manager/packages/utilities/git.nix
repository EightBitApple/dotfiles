{ config, lib, pkgs, ... }:

{
  options.git.enable = lib.mkEnableOption ''
    Install and configure git.
  '';
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "The8BitApple";
      userEmail = "stefanharris16@gmail.com";
      aliases = {
        pu = "push";
        co = "checkout";
        cm = "commit";
      };
    };
  };
}
