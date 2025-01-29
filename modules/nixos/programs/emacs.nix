{ userSettings, ... }:

{
  services.emacs = {
    install = true;
    enable = true;
    startWithGraphical = true;
    package = userSettings.emacsPkg;
  };
}
