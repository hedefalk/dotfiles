{ pkgs, lib, ... }:

{
  # Gaming profile for gaming and entertainment - only current tools

  environment.systemPackages = with pkgs; [
    # Currently no gaming-specific system packages
  ];

  # Gaming-specific Homebrew packages (matching current setup)
  homebrew = {
    casks = [
      # Gaming platforms
      "steam"
      
      # Game streaming and remote play
      "parsec"
      
      # Emulators
      "openemu"
      
      # Gaming utilities and Windows compatibility
      "whisky" # Wine wrapper for Windows games
      
      # Communication for gaming
      "discord"
      
      # Entertainment and media
      "vlc"
      "spotify"
      "freetube"
      
      # Performance monitoring
      "stats" # system monitor
      
      # Recording and streaming
      "obs"
    ];
    
    brews = [
      # Currently no gaming-specific brews
    ];
    
    taps = [
      # Already covered in base profiles
    ];
    
    masApps = {
      # Gaming and entertainment from Mac App Store
      # (none currently specified in existing config)
    };
  };

  # Gaming-specific system configuration
  system.defaults = {
    # Optimize for gaming performance
    dock = {
      autohide = true;
      autohide-delay = 0.0; # Instant hide for gaming
    };
  };
}