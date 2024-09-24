{
  description = "A Nix Flake for both NixOS system configuration and home-manager.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/24.05";

    home-manager = {
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
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
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

      userSettings = {
        username = "stefan";
        name = "Stefan";
        dotfilesDir = "~/.dotfiles";

        windowManager = "hyprland";
        browser = "firefox";
        terminal = "alacritty";
        terminalTitle = "Alacritty";

        monospaceFont = "FiraCode Nerd Font";
        monospaceFontPkg = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };

        sansSerifFont = "DejaVu Sans";
        sansSerifFontPkg = pkgs.dejavu_fonts;

        serifFont = "DejaVu Serif";
        serifFontPkg = pkgs.dejavu_fonts;

        emacsPkg = pkgs.emacs29-pgtk;

        wallpaperDay = ./modules/home-manager/resources/content/wallpapers/Clearday.jpg;
        wallpaperNight = ./modules/home-manager/resources/content/wallpapers/Cloudsnight.jpg;
        wallpaperNeutral = ./modules/home-manager/resources/content/wallpapers/nix-black-4k.png;
        wallpaperLock = ./modules/home-manager/resources/content/wallpapers/line_icons.png;

      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.arch};
      pkgs-stable = nixpkgs-stable.legacyPackages.${systemSettings.arch};
      lib = nixpkgs.lib;

      hostArgs = {
        inherit systemSettings;
        inherit userSettings;
        inherit pkgs-stable;
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

            home-manager.nixosModules.home-manager
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

            home-manager.nixosModules.home-manager
            {
              home-mamager = {
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
