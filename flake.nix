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

  outputs = inputs@{ nixpkgs, self, nix-darwin, home-manager, nix-homebrew }:
  let
    # Create our library functions
    lib = import ./lib { inherit inputs; };

    # Import machine configurations
    machineConfigs = import ./machines.nix {
      inherit inputs;
      lib = nixpkgs.lib;
    };
  in
  {
    # Export our library for use in other parts of the flake
    lib = lib;

    # Generate darwin configurations using our abstractions
    darwinConfigurations = machineConfigs.darwinConfigurations;

    # Optional: Export machine definitions for inspection
    machines = machineConfigs.machines;
  };
}
