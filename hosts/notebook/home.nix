{ pkgs, lib, ... }:

{
  imports = [ ../../modules/home-manager ];

  disabledModules = [
    ../../modules/home-manager/packages/gaming/mangohud.nix
    ../../modules/home-manager/packages/gaming/sourceports/dsda-doom.nix
    ../../modules/home-manager/packages/gaming/sourceports/gzdoom.nix
    ../../modules/home-manager/packages/gaming/sourceports/ironwail.nix
    ../../modules/home-manager/packages/text-editors/emacs.nix
    ../../modules/home-manager/packages/utilities/development/virtualisation.nix
    ../../modules/home-manager/packages/utilities/editing/documents.nix
    ../../modules/home-manager/packages/utilities/editing/image.nix
    ../../modules/home-manager/packages/utilities/editing/text.nix
    ../../modules/home-manager/packages/utilities/network/email.nix
    ../../modules/home-manager/packages/utilities/network/syncthing.nix
    ../../modules/home-manager/packages/utilities/security.nix
  ];
}
