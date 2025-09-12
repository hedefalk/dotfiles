{ pkgs, lib, inputs, hostname, ... }:

let
  inherit (inputs.self.lib) mkFeatures mergeHomebrew;
in
{
  # Host-specific configuration for Mac Studio
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Features are handled automatically by the lib function

  # Host-specific packages
  environment.systemPackages = with pkgs; [
    any-nix-shell
    protols # Protocol buffer language server
  ];

  # Host-specific Homebrew configuration
  homebrew = mergeHomebrew [
    # Studio-specific applications
    {
      casks = [
        "ddpm" # Dell Display and Peripheral Manager
        "logi-options+" # Logitech device management
        "deskpad" # Virtual screen for screen sharing
        "MonitorControl" # External monitor brightness control
        "stats" # System monitor and fan control
        "steam" # Gaming platform
        "karabiner-elements" # Advanced keyboard remapping
      ];

      brews = [];

      taps = [];

      masApps = {
        bredbandskollen = 1147976909; # Internet speed test
      };
    }
  ];

  # Host-specific system settings optimized for desktop use
  system.defaults = {
    # Studio-specific optimizations for desktop workflow
    dock = {
      tilesize = lib.mkForce 32; # Larger dock for desktop with more screen real estate
      magnification = lib.mkForce true;
      largesize = lib.mkForce 48;
    };

    # Desktop-optimized settings
    NSGlobalDomain = {
      # Faster animations for desktop use
      NSWindowResizeTime = lib.mkForce 0.1;
      
      # Desktop keyboard settings
      KeyRepeat = lib.mkForce 1; # Fastest key repeat for productivity
      InitialKeyRepeat = lib.mkForce 8;
    };

    # Multiple monitor support
    spaces.spans-displays = lib.mkForce false; # Separate spaces per display
  };

  # Studio-specific environment variables
  environment.variables = {
  };

  # Studio-specific services and daemons
  # Could add custom launch agents here for studio-specific needs
}
