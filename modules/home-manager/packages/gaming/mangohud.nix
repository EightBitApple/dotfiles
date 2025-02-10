{
  config,
  lib,
  pkgs,
  ...
}:
let
  mangoHudPath = "${config.home.homeDirectory}/dotfiles/modules/home-manager/packages/gaming/MangoHud.conf";
in

{
  home.packages = [ pkgs.mangohud ];
  xdg.configFile."MangoHud/MangoHud.conf".source = config.lib.file.mkOutOfStoreSymlink mangoHudPath;

}
