{
  pkgs,
  config,
  lib,
  userSettings,
  inputs,
  ...
}:

{
  options.emacs.enable = lib.mkEnableOption ''
    Install and configure Doom Emacs.
  '';

  config = lib.mkIf config.emacs.enable {
    programs = {
      emacs = {
        enable = true;
        package = userSettings.emacsPkg;
        extraPackages = epkgs: [ epkgs.vterm ];
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
      jdk

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
