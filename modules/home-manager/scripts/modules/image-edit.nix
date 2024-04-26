{ pkgs, lib, config, ... }:

{
  options.imageEdit.enable = lib.mkEnableOption ''
    Enable script which uses swappy to quickly edit images in the clipboard.
  '';

  config = lib.mkIf config.imageEdit.enable {
    home.packages = with pkgs;
      [
        (pkgs.writeShellApplication {
          name = "img-edit";
          runtimeInputs = with pkgs; [ swappy wl-clipboard ];
          text = ''
            wl-paste | swappy -f -
          '';
        })
      ];
  };
}
