{ userSettings, ... }:

{
  home.packages = [ userSettings.monospaceFont.package ];
}
