{
  description = "A Nix Flake for both NixOS system configuration and home-manager.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      systemSettings = rec {
        arch = "x86_64-linux";
        homename = "nixos";

        timezone = "Europe/London";
        latitude = "51.50853";
        longitude = "-0.12574";

        locale = "en_GB.UTF-8";
      };

      userSettings = {
        username = "stefan";
        name = "Stefan";
        dotfilesDir = "~/.dotfiles";

        windowManager = "hyprland";
        browser = "firefox";
        terminal = "foot";

        monospaceFont = "FiraCode Nerd Font";
        monospaceFontPkg = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };

        sansSerifFont = "DejaVu Sans";
        sansSerifFontPkg = pkgs.dejavu_fonts;

        serifFont = "DejaVu Serif";
        serifFontPkg = pkgs.dejavu_fonts;

        editor = "emacsclient";
        emacsPkg = pkgs.emacs29-pgtk;
        wallpaper = ./modules/home-manager/resources/content/wallpapers/forest.jpg;
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.arch};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.arch};
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./hosts/desktop/configuration.nix
            ./modules/nixos
          ];
        };

        laptop = lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./hosts/laptop/configuration.nix
            ./modules/nixos
          ];
        };
      };

      homeConfigurations = {
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./hosts/desktop/home.nix
            ./modules/home-manager
            stylix.homeManagerModules.stylix
          ];
        };
      };

      homeConfigurations = {
        laptop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./hosts/laptop/home.nix
            ./modules/home-manager
            stylix.homeManagerModules.stylix
          ];
        };
      };
    };
}
