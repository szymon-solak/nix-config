{
  description = "Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    stylix,
    nur,
    lanzaboote,
    agenix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      kirin = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/kirin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.szymon = import ./home-manager/home.nix;
          }
        ];
      };

      nezumi = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          lanzaboote.nixosModules.lanzaboote
          agenix.nixosModules.default
          {environment.systemPackages = [agenix.packages."x86_64-linux".default];}
          ./hosts/nezumi
          nur.modules.nixos.default
          {nixpkgs.overlays = [nur.overlays.default];}
          (import ./overlays)
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.szymon = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };

      bee = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          agenix.nixosModules.default
          (import ./overlays)
          ./hosts/bee
        ];
      };
    };

    darwinConfigurations = {
      mercury = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/mercury
          nur.modules.darwin.default
          {nixpkgs.overlays = [nur.overlays.default];}
          home-manager.darwinModules.home-manager
          (import ./overlays)
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.szymonsolak = import ./home-manager/darwin.nix;
            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}
