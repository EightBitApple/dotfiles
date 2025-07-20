{ pkgs, ... }:

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
    ripgrep
    gnumake
    nodejs

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        # lsp-bridge dependencies
        epc
        orjson
        sexpdata
        six
        setuptools
        paramiko
        rapidfuzz
        watchdog
        packaging
      ]
    ))

    # java
    jdk
    jdt-language-server

    #nix
    nixd

    # org babel
    plantuml
    graphviz

    # rust
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy

    # dap-gdb
    gdb
  ];
}
