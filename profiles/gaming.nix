{ pkgs, lib, ... }:

{
  environment.systemPackages = [
  ];

  homebrew = {
    casks = [
      "steam"
      "whisky" # Wine wrapper for Windows games
      "discord"
      "vlc"
      "spotify"
      "freetube"
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
