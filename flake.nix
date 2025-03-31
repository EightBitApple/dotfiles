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
        arch = {
          x86 = "x86_64-linux";
          arm = "aarch64-linux";
        };

        networking.hostname = "nixos";

        location = {
          timezone = "Europe/London";
          latitude = "51.50853";
          longitude = "-0.12574";
          locale = "en_GB.UTF-8";
        };

        maintenance.day = "Tue";
      };

      userSettings = rec {
        user = {
          name = "stefan";
          fullName = "Stefan";
          dotfilesDir = "/home/${user.name}/dotfiles/";
        };

        emacs = {
          name = "emacsclient";
          package = pkgs.emacs-pgtk;
        };

        windowManager = {
          name = "hyprland";
          cursorSize = 24;
          wallpaper = ./modules/home-manager/resources/wallpapers/vista.jpg;
        };

        browser = "librewolf";

        terminal = {
          name = "alacritty";
          title = "Alacritty";
        };

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
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.arch.x86};
      pkgsStable = nixpkgsStable.legacyPackages.${systemSettings.arch.x86};
      pkgsArm = nixpkgsStable.legacyPackages.${systemSettings.arch.arm};

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
                users.${userSettings.user.name} = import ./hosts/laptop/home.nix;
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
                users.${userSettings.user.name} = import ./hosts/desktop/home.nix;
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
