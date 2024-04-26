{ config, lib, pkgs, ... }:

{
  options.appLauncher.enable = lib.mkEnableOption ''
    Install and configure the Tofi application launcher.
  '';

  config = lib.mkIf config.appLauncher.enable {
    home.packages = with pkgs; [ tofi ];

    home.file.".config/tofi/config".text = with config.colorScheme.colors; ''
      text-color = #${base07}
      selection-color = #${base0B}

      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-left = 35%
      padding-top = 35%
      result-spacing = 25
      num-results = 5
      font = monospace
      background-color = #${base00}AA
    '';
  };
}
