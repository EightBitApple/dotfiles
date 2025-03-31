{ systemSettings, ... }:

{
  time.timeZone = "${systemSettings.location.timezone}";
  i18n.defaultLocale = "${systemSettings.location.locale}";
}
