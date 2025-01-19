{
  description = "A Nix Flake for both NixOS system configuration and home-manager.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgsStable.url = "nixpkgs/nixos-24.11";

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "homeManager";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgsStable,
      homeManager,
      ...
    }@inputs:
    let
      systemSettings = {
        arch = "x86_64-linux";
        hostname = "nixos";

        timezone = "Europe/London";
        latitude = "51.50853";
        longitude = "-0.12574";
        locale = "en_GB.UTF-8";

        maintenanceDay = "Tue";
      };

      userSettings = rec {
        username = "stefan";
        name = "Stefan";
        dotfilesDir = "/home/${username}/dotfiles/";

        editor = "emacs";
        windowManager = "hyprland";
        browser = "firefox";
        terminal = "alacritty";
        terminalTitle = "Alacritty";

        monospaceFont = "FiraCode Nerd Font";
        monospaceFontPkg = pkgs.nerd-fonts.fira-code;

        sansSerifFont = "DejaVu Sans";
        sansSerifFontPkg = pkgs.dejavu_fonts;

        serifFont = "DejaVu Serif";
        serifFontPkg = pkgs.dejavu_fonts;

        emacsPkg = pkgs.emacs29-pgtk;

        wallpaper = ./modules/home-manager/resources/wallpapers/nix-wallpaper-nineish-dark-gray.jpg;
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.arch};
      pkgsStable = nixpkgsStable.legacyPackages.${systemSettings.arch};

      lib = nixpkgs.lib;

      hostArgs = {
        inherit systemSettings;
        inherit userSettings;
        inherit pkgsStable;
        inherit inputs;
      };
    in
    {
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          specialArgs = hostArgs;
          modules = [
            ./hosts/laptop/configuration.nix
            ./modules/nixos

            inputs.disko.nixosModules.disko
            inputs.stylix.nixosModules.stylix

            homeManager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = hostArgs;
                users.${userSettings.username} = import ./hosts/laptop/home.nix;
              };
            }
          ];
        };

        desktop = lib.nixosSystem {
          specialArgs = hostArgs;
          modules = [
            ./hosts/desktop/configuration.nix
            ./modules/nixos

            inputs.disko.nixosModules.disko
            inputs.stylix.nixosModules.stylix

            homeManager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = hostArgs;
                users.${userSettings.username} = import ./hosts/desktop/home.nix;
              };
            }
          ];
        };
      };
    };
}
