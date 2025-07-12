{ pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    discount # markdown linter and formatter
    shellcheck
    cmakeMinimal
    nixfmt-rfc-style
    glslang
    clang
    clang-tools
    libtool
    shfmt
    python3
    ripgrep
    gnumake
    nodejs

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
  ];
}
