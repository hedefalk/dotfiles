{ inputs, ... }:

let
  inherit (inputs.nixpkgs) lib;
in
rec {
  # Helper function to create a darwin system configuration
  mkDarwinSystem = {
    hostname,
    system ? "aarch64-darwin",
    modules ? [],
    extraSpecialArgs ? {},
    users ? { viktor = import ../home/home.nix; },
    homeExtraSpecialArgs ? {}
  }: 
  inputs.nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit inputs hostname;
    } // extraSpecialArgs;
    modules = [
      # Base system configuration
      ../profiles/base.nix
      ../profiles/darwin.nix
      
      # Feature-based modules
    ] ++ (mkFeatures (extraSpecialArgs.features or {})) ++ [
      
      # Host-specific configuration
      ../hosts/${hostname}.nix
      
      # Home Manager integration
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs hostname;
            self = inputs.self;
          } // homeExtraSpecialArgs;
          users = users;
        };
      }
    ] ++ modules;
  };

  # Helper function to generate multiple darwin configurations
  mkDarwinSystems = configs: lib.mapAttrs (name: config: mkDarwinSystem (config // { hostname = name; })) configs;

  # Helper function to merge homebrew configurations
  mergeHomebrew = configs: 
    let
      mergeLists = key: lib.flatten (map (config: config.${key} or []) configs);
      mergeAttrs = key: lib.fold (a: b: a // b) {} (map (config: config.${key} or {}) configs);
    in {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
      };
      casks = mergeLists "casks";
      brews = mergeLists "brews";
      taps = mergeLists "taps";
      masApps = mergeAttrs "masApps";
    };

  # Helper to conditionally include modules based on conditions
  optionalModule = condition: module: lib.optional condition module;
  
  # Helper to create user configurations
  mkUser = {
    name,
    home ? "/Users/${name}",
    shell ? "fish",
    isAdmin ? false
  }: {
    users.users.${name} = {
      inherit name home shell;
    } // lib.optionalAttrs isAdmin {
      # Add admin-specific configuration here if needed
    };
  };

  # Helper to enable/disable features based on host capabilities
  mkFeatures = features: lib.flatten [
    (optionalModule (features.development or false) ../profiles/development.nix)
    (optionalModule (features.creative or false) ../profiles/creative.nix)
    (optionalModule (features.gaming or false) ../profiles/gaming.nix)
  ];
}