{ config, lib, pkgs, ... }:

{
  options.accounts.enable = lib.mkEnableOption ''
    Define a user account.
  '';

  config = lib.mkIf config.accounts.enable {
    users.users.stefan = {
      isNormalUser = true;
      description = "Stefan";
      extraGroups = [ "networkmanager" "wheel" "wireshark" "gamemode" ];
      shell = pkgs.zsh;
    };
  };
}
