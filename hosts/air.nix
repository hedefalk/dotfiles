{ pkgs, lib, inputs, hostname, ... }:

let
  inherit (inputs.self.lib) mkFeatures mergeHomebrew;
in
{
  # Host-specific configuration for MacBook Air
  nixpkgs.hostPlatform = "aarch64-darwin";
  
  # Enable features for this machine
  imports = [
    (mkFeatures {
      development = true;
      creative = false;
      gaming = false;
    }).imports
  ];
  
  # Host-specific packages
  environment.systemPackages = with pkgs; [
    any-nix-shell
  ];

  # Host-specific Homebrew configuration
  homebrew = mergeHomebrew [
    # No additional homebrew packages for air by default
    # Can be extended as needed
    {
      casks = [];
      brews = [];
      taps = [];
      masApps = {};
    }
  ];

  # Host-specific system settings
  system.defaults = {
    # Air-specific optimizations
    dock = {
      tilesize = 16; # Smaller dock for laptop screen
    };
    
    # Battery optimization
    NSGlobalDomain = {
      # Slightly slower animations to save battery
      NSWindowResizeTime = 0.2;
    };
  };

  # Air-specific environment variables
  environment.variables = {
    # Laptop-specific settings
    MACHINE_TYPE = "laptop";
  };
}