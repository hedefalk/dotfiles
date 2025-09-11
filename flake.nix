{
  description = "Viktor's nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ nixpkgs, self, nix-darwin, home-manager,
    nix-homebrew
  }:
  {
    darwinConfigurations = {
        Viktors-MacBook-Air = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./shared/common.nix
              # nix-homebrew.darwinModules.nix-homebrew
              ./shared/mac.nix
              ./hosts/air.nix
              home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit self; }; # pass self (flake) to home.nix
                    home-manager.users.viktor = import ./home/home.nix;
                }
            ];
        };
        Air15 = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./shared/common.nix
              nix-homebrew.darwinModules.nix-homebrew
              {
                nix-homebrew = {
                    # Install Homebrew under the default prefix
                    enable = true;

                    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                    enableRosetta = true;

                    # User owning the Homebrew prefix
                    user = "viktor";

                    # Optional: Declarative tap management
                    # taps = {
                    # "homebrew/homebrew-core" = homebrew-core;
                    # "homebrew/homebrew-cask" = homebrew-cask;
                    # };

                    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
                    mutableTaps = true;
                };
              }
              ./shared/mac.nix
              ./hosts/air.nix
              home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit self; }; # pass self (flake) to home.nix
                    home-manager.users.viktor = import ./home/home.nix;
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
                    home-manager.users.viktor = import ./home/home.nix;
                }
            ];
        };
    };
  };
}
