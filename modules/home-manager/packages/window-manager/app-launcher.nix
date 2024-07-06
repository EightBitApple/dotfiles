{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.appLauncher.enable = lib.mkEnableOption ''
    Install and configure the Tofi application launcher.
  '';

  config = lib.mkIf config.appLauncher.enable {
    programs.tofi = {
      enable = true;
      settings = with config.stylix.base16Scheme; {
        anchor = "top";
        width = "100%";
        height = 27;
        horizontal = true;
        font-size = lib.mkForce 11;
        prompt-text = " run: ";
        outline-width = 0;
        border-width = 0;
        min-input-width = 120;
        result-spacing = 15;
        padding-top = 3;
        padding-bottom = 0;
        padding-left = 0;
        padding-right = 0;

        selection-background = lib.mkForce "#${base07}";
        selection-background-padding = 1;
        selection-color = lib.mkForce "#${base00}";
      };
    };
  };
}
