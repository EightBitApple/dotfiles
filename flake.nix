{
  description = "A Nix Flake for both NixOS system configuration and home-manager.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgsStable.url = "nixpkgs/nixos-24.11";

    sopsNix.url = "github:Mic92/sops-nix";

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
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
        archArm = "aarch64-linux";
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

        editor = "emacsclient";
        windowManager = "hyprland";
        cursorSize = 24;
        browser = "librewolf";
        terminal = "alacritty";
        terminalTitle = "Alacritty";

        monospaceFont = {
          name = "FiraCode Nerd Font";
          package = pkgs.nerd-fonts.fira-code;
        };

        serifFont = {
          name = "DejaVu Serif";
          package = pkgs.dejavu_fonts;
        };

        sansSerifFont = {
          name = "DejaVu Sans";
          package = pkgs.dejavu_fonts;
        };

        emacsPkg = pkgs.emacs-pgtk;

        wallpaper = ./modules/home-manager/resources/wallpapers/vista.jpg;
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.arch};
      pkgsStable = nixpkgsStable.legacyPackages.${systemSettings.arch};
      pkgsArm = nixpkgsStable.legacyPackages.${systemSettings.archArm};

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
            ./overlays

            inputs.disko.nixosModules.disko

            homeManager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = hostArgs;
                users.${userSettings.username} = import ./hosts/laptop/home.nix;
                useUserPackages = true;
              };
            }
          ];
        };

        desktop = lib.nixosSystem {
          specialArgs = hostArgs;
          modules = [
            ./hosts/desktop/configuration.nix
            ./modules/nixos
            ./overlays

            inputs.disko.nixosModules.disko

            homeManager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = hostArgs;
                users.${userSettings.username} = import ./hosts/desktop/home.nix;
                useUserPackages = true;
              };
            }
          ];
        };

        pi-home = nixpkgsStable.lib.nixosSystem {
          specialArgs = hostArgs;
          modules = [
            {
              nixpkgs.config.pkgs = pkgsArm;
            }
            ./hosts/pi-home/configuration.nix
            ./modules/nixos
          ];
        };
      };
    };
}
