{ pkgs, userSettings, ... }:

{
  programs.emacs = {
    enable = true;
    package = userSettings.emacs.package;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    discount # markdown linter and formatter
    shellcheck
    cmakeMinimal
    nixfmt
    glslang
    clang
    fd
    clang-tools
    libtool
    shfmt
    python3
    ripgrep
    gnumake
    nodejs
    languagetool
    ty
    python314Packages.flake8
    python314Packages.pep8
    python314Packages.autopep8

    # java lsp
    jdk

    # org babel
    plantuml
    graphviz

    # rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # dap-gdb
    gdb
  ];
}
