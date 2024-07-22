{ config, lib, ... }:

{
  options.git.enable = lib.mkEnableOption ''
    Install and configure git.
  '';
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "EightBitApple";
      userEmail = "stefanharris16@gmail.com";
      aliases = {
        pu = "push";
        co = "checkout";
        cm = "commit";
      };
    };
  };
}
