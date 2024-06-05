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
    home.packages = with pkgs; [ tofi ];

    home.file.".config/tofi/config".text = with config.colorScheme.palette; ''
      text-color = #${base07}
      selection-color = #${base0B}

      font = monospace
      corner-radius = 2
      outline-color = #${base01}
      outline-width = 2
      border-color = #${base02}
      border-width = 2
      background-color = #${base00}
      text-color = #${base07}
      selection-color = #${base0B}
      prompt-text = "run: "
      num-results = 8
      width = 640
      height = 480
    '';
  };
}
