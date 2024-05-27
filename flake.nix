{
  description = "Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		# TODO: 24.05
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      kirin = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-unstable =
            import nixpkgs-unstable {system = "x86_64-linux";};
        };
        modules = [
          ./hosts/kirin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.szymon = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              pkgs-unstable =
                import nixpkgs-unstable {system = "x86_64-linux";};
            };
          }
        ];
      };
    };

    darwinConfigurations = {
      mercury = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/mercury
          home-manager.darwinModules.home-manager
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
