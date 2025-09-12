{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # Currently no gaming-specific system packages
  ];

  # Gaming-specific Homebrew packages (matching current setup)
  homebrew = {
    casks = [
      # Gaming platforms
      "steam"
      "whisky" # Wine wrapper for Windows games
      "discord"
      "vlc"
      "spotify"
      "freetube"
      # Performance monitoring
      "stats" # system monitor
      "obs"
    ];

    brews = [
    ];

    taps = [
    ];

    masApps = {
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0; # Instant hide for gaming
    };
  };
}
