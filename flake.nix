{
  description = "Viktor's nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, self, nix-darwin, home-manager }:
  {
    darwinConfigurations = {
        Viktors-MacBook-Air = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./shared/common.nix
              ./shared/mac.nix
              ./hosts/air.nix
              home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit self; }; # pass self (flake) to home.nix
                    home-manager.users.viktor = ./home/home.nix;
                }
            ];
        };
        Air15 = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./shared/common.nix
              ./shared/mac.nix
              ./hosts/air.nix
              home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit self; }; # pass self (flake) to home.nix
                    home-manager.users.viktor = ./home/home.nix;
                }
            ];
        };
        Viktors-Mac-Studio = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./shared/common.nix
              ./shared/mac.nix
              ./hosts/studio.nix
              home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit self; }; # pass self (flake) to home.nix
                    home-manager.users.viktor = ./home/home.nix;
                }
            ];
        };
    };
  };
}
