{ pkgs, userSettings, ... }:

{
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
    black
    pipenv
    python312Packages.pyflakes
    python312Packages.isort
    python312Packages.pytest_7

    # org babel
    plantuml
    graphviz

    # rust
    cargo
    rustc
    rust-analyzer
  ];
}
