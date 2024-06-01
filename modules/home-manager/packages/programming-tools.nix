{ config, lib, pkgs, ... }:

{
  options.programmingTools.enable = lib.mkEnableOption ''
    Install programming tools.
  '';

  config = lib.mkIf config.textEditors.enable {
    home.packages = with pkgs; [
      discount # markdown linter and formatter
      shellcheck
      cmakeMinimal
      nixfmt-rfc-style
      glslang
      libclang
      libtool
      shfmt
    ];
  };
}
