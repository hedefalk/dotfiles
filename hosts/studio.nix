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
      tilesize = 32; # Larger dock for desktop with more screen real estate
      magnification = true;
      largesize = 48;
    };
    
    # Desktop-optimized settings
    NSGlobalDomain = {
      # Faster animations for desktop use
      NSWindowResizeTime = 0.1;
      
      # Desktop keyboard settings
      KeyRepeat = 1; # Fastest key repeat for productivity
      InitialKeyRepeat = 8;
    };
    
    # Multiple monitor support
    spaces.spans-displays = false; # Separate spaces per display
  };

  # Studio-specific environment variables
  environment.variables = {
    # Desktop-specific settings
    MACHINE_TYPE = "desktop";
    
    # Multi-monitor setup
    DISPLAY_COUNT = "2";
    
    # Performance settings for more powerful hardware
    NODE_OPTIONS = "--max-old-space-size=16384"; # More memory for Node.js
    JAVA_OPTS = "-Xmx8g"; # More memory for Java applications
  };

  # Studio-specific services and daemons
  # Could add custom launch agents here for studio-specific needs
}