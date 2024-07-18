{
  config,
  lib,
  pkgs,
  systemSettings,
  ...
}:

{
  options.locale.enable = lib.mkEnableOption ''
    Set the time zone and locale settings.
  '';

  config = lib.mkIf config.locale.enable {
    time.timeZone = "${systemSettings.timezone}";
    i18n = {
      defaultLocale = "${systemSettings.locale}";
      extraLocaleSettings = {
        LC_ADDRESS = "${systemSettings.locale}";
        LC_IDENTIFICATION = "${systemSettings.locale}";
        LC_MEASUREMENT = "${systemSettings.locale}";
        LC_MONETARY = "${systemSettings.locale}";
        LC_NAME = "${systemSettings.locale}";
        LC_NUMERIC = "${systemSettings.locale}";
        LC_PAPER = "${systemSettings.locale}";
        LC_TELEPHONE = "${systemSettings.locale}";
        LC_TIME = "${systemSettings.locale}";
      };
    };
  };
}
