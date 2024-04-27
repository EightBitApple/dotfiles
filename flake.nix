{
  description =
    "A Nix Flake for both NixOS system configuration and home-manager.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      systemSettings = rec {
        arch = "x86_64-linux";
        homename = "nixos";
        timezone = "Europe/London";
        locale = "en_GB.UTF-8";
      };

      userSettings = {
        username = "stefan";
        name = "Stefan";
        dotfilesDir = "~/.dotfiles";

        windowManager = "hyprland";
        browser = "firefox";
        terminal = "foot";

        font = "FiraCode Nerd Font";
        fontPkg = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };

        editor = "emacsclient";
        emacsPkg = pkgs.emacs29-pgtk;
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.arch};
      pkgs-stable = nixpkgs-stable.legacyPackages.${systemSettings.arch};
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [ ./hosts/desktop/configuration.nix ./modules/nixos ];
        };
      };

      homeConfigurations = {
        stefan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [ ./home.nix ./modules/home-manager ];
        };
      };
    };
}
