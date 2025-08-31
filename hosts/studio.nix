{ pkgs, ... }:

{
  # imports = [ <home-manager/nix-darwin> ];
  nixpkgs.hostPlatform    = "aarch64-darwin";
  environment.systemPackages = with pkgs; [
    # monkeysphere  # not supported on ‘aarch64-darwin
    any-nix-shell
    protols
  ];

  programs = {
  };

  homebrew = {
    casks = [
        "ddpm" # Dell Display and Peripheral Manager
        "logi-options+"
        "deskpad" # virtual screen for screen sharing smaller size
        "MonitorControl"
        "stats" # for fan control
        "steam"
        "karabiner-elements" # keyboard remapping
    ];
    taps = [
    ];
    brews = [
    ];
    masApps = {
         bredbandskollen = 1147976909;
    };
  };
}
