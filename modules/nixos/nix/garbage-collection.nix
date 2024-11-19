{
  config,
  lib,
  systemSettings,
  ...
}:

{
  options.garbageCollection.enable = lib.mkEnableOption ''
    Enable weekly garbage collection.
  '';

  config = lib.mkIf config.garbageCollection.enable {
    nix.gc = {
      automatic = true;
      dates = "${systemSettings.maintenanceDay}";
      options = "--delete-older-than 14d";
    };
  };
}
