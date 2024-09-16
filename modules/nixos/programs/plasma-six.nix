{ config, lib, ... }:

{
  options.plasma6.enable = lib.mkEnableOption ''
    Enable the use of KDE plasma.
  '';

  config = lib.mkIf config.plasma6.enable {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      desktopManager = {
        services.desktopManager.plasma6.enable = true;
      };
    };
  };
}
