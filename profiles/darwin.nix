{ pkgs, lib, hostname, ... }:

{
  # Darwin-specific configuration that applies to all macOS machines
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Nix configuration
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  
  # System packages specific to macOS
  environment.systemPackages = with pkgs; [
    # Development tools from existing config
    (google-cloud-sdk.withExtraComponents [ 
      google-cloud-sdk.components.gke-gcloud-auth-plugin 
    ])
    act # local github actions
    ansible
    any-nix-shell
    atuin # shell history sync
    awscli2
    colima # docker-desktop alternative
    coreutils # gnu ls among things
    devenv
    docker
    fzf # This is the PROGRAM fzf, in fisher there's integration with fish
    glab # Gitlab CLI
    git
    git-lfs
    gitAndTools.delta
    github-cli
    gnupg
    grpcurl
    k3sup
    k9s
    kind # k8s
    kubeswitch
    lazygit
    mkcert
    neovim
    nixd # nix language server
    nixpkgs-fmt
    pass
    stow
    vscode
    wget
  ];

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  # Optional services
  services.dnsmasq = {
    enable = false;
  };

  # Homebrew configuration
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    casks = [
      "adobe-digital-editions" # library epub reader
      "alt-tab" # alternative switcher
      "arduino-ide"
      "bankid"
      "bitwarden"
      "blender"
      "calibre"
      "cardinal"
      "digikam"
      "discord"
      "ungoogled-chromium"
      "librewolf"
      "freetube"
      "geekbench"
      "ghostty" # terminal
      "gimp" # why not
      "google-chrome"
      "google-drive"
      "grandperspective" # disk usage
      "inkscape"
      "intellij-idea-ce"
      "keepassx"
      "keycastr"
      "kicad"
      "kitty"
      "libreoffice"
      "logseq" # notes
      "maccy"
      "microsoft-edge"
      "mockoon"
      "obs"
      "obsidian"
      "ollama" # nix-darwin wasn't merged, nixos only cuda and amd
      "openscad@snapshot"
      "openshot-video-editor" # no good - couldn't do custom resolution or match input…?
      "orcaslicer"
      "raspberry-pi-imager"
      "rawtherapee" # photo editor
      "raycast" # launcher
      "rectangle" # tiling window manager
      "signal"
      "silicon-info" # To check arch
      "slack"
      "spotify"
      "tor-browser"
      "ultimaker-cura"
      "vcv-rack" # modular synth
      "vlc"
      "wezterm"
      "whisky" #wine windows emulator
      "zed@preview" # text editor"
      "zoom" # zoom.us
    ];
    taps = [
      "chipmk/tap"
      "datawire/blackbird"
      "oven-sh/bun"
      "wez/wezterm"
    ];
    brews = [
      "awscli"
      "bitwarden-cli"
      "datawire/blackbird/telepresence-arm64"
      "gitlab-ci-local"
      "gmsh" # To view stl's
      "helm"
      "k3sup"
      "kubernetes-cli"
      "mas" # mac app store
      "mkcert" # create self-signed certs for dev env
      "pinentry-mac" # gpg
      "wimlib" # To split windows iso files > 4GB for bootable USB
    ];
    masApps = {
      logic = 634148309;
      iordning = 1157906903;
      tailscale = 1475387142;
    };
  };

  # Shell configuration
  programs = {
    zsh.enable = true;
    fish = {
      enable = true;
    };
  };

  # Available shells
  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  # macOS system defaults
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
    };
    loginwindow.LoginwindowText = "REWARD IF LOST: hedefalk@gmail.com";
    screencapture.location = "~/Screenshots";
    screensaver.askForPasswordDelay = 10;

    dock = {
      autohide = true;
      show-recents = false;
      launchanim = true;
      orientation = "bottom";
      tilesize = lib.mkDefault 20;
    };

    NSGlobalDomain = {
      _HIHideMenuBar = false;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;

      # 120, 90, 60, 30, 12, 6, 2
      KeyRepeat = 2;

      # 120, 94, 68, 35, 25, 15
      InitialKeyRepeat = 15;

      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;
    };
  };

  # Activation script to apply system preferences
  system.activationScripts.activateSettings.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Primary user configuration
  system.primaryUser = "viktor";
  
  users.users.viktor = {
    name = "viktor";
    home = "/Users/viktor";
    shell = pkgs.fish;
  };

  # System state version
  system.stateVersion = 5;
}