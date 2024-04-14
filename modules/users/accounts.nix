{ config, lib, pkgs, ... }:

{
  options.accounts.enable = lib.mkEnableOption ''
    Define a user account.
  '';

  config = lib.mkIf config.accounts.enable {
    users.users.stefan = {
      isNormalUser = true;
      description = "Stefan Harris";
      extraGroups = [ "networkmanager" "wheel" "wireshark" ];
      shell = pkgs.zsh;
    };
  };
}
