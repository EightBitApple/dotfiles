{
  pkgs,
  config,
  lib,
  userSettings,
  inputs,
  ...
}:

{
  options.doomEmacs.enable = lib.mkEnableOption ''
    Install and configure Doom Emacs.
  '';

  config = lib.mkIf config.doomEmacs.enable {
    programs = {
      emacs = {
        enable = true;
        package = userSettings.emacsPkg;
        extraPackages = epkgs: [ epkgs.vterm ];
      };
    };

    home = {
      sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
      sessionVariables = {
        DOOMDIR = "${config.xdg.configHome}/doom-config";
        DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
        DOOMPROFILELOADFILE = "${config.xdg.configHome}/doom-local/load.el";
      };
    };

    xdg = {
      enable = true;
      configFile = {
        "doom-config/config.el".source = ./config.el;
        "doom-config/init.el".source = ./init.el;
        "doom-config/packages.el".source = ./packages.el;

        "emacs" = {
          source = inputs.doom-emacs;

          onChange = "${pkgs.writeShellScript "doom-change" ''
            export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
            export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
            export DOOMPROFILELOADFILE="${config.home.sessionVariables.DOOMPROFILELOADFILE}";

            if [ ! -d "$DOOMLOCALDIR" ]; then
              ${config.xdg.configHome}/emacs/bin/doom -y install
            else
              ${config.xdg.configHome}/emacs/bin/doom -y sync -u
            fi
          ''}";
        };
      };
    };

    home.packages = with pkgs; [
      discount # markdown linter and formatter
      shellcheck
      cmakeMinimal
      nixfmt-rfc-style
      glslang
      libclang
      libtool
      shfmt
      python3
      ripgrep
      gnumake
      nodejs

      # java lsp
      jdk22

      # python lsp
      ruff-lsp
      black
      pipenv
      python312Packages.pyflakes
      python312Packages.isort
      python312Packages.nose
      python312Packages.pytest_7
    ];
  };
}
