{  pkgs, ... }:

{
  # imports = [ <home-manager/nix-darwin> ];
  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # (texlive.combine { inherit (texlive) scheme-medium fontspec luacode; })
    # browserpass
    # monkeysphere  # not supported on ‘aarch64-darwin
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    act # local github actions
    ansible
    any-nix-shell
    atuin # shell history sync
    awscli2
    colima # docker-desktop alternative
    coreutils # gnu ls among things
    coursier
    devenv
    docker
    fzf # This is the PROGRAM fzf, in fisher there's integration with fish https://github.com/jethrokuan/fzf
    git
    git-lfs
    gitAndTools.delta
    gitAndTools.gh
    gnupg
    grpcurl
    jdk
    jetbrains-mono # font for editors and terminals
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
    # tectonic # latex
    texlive.combined.scheme-full # couldn't get lua to work with tectonic, need lualatex
    vscode
    wget
  ];

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  # https://www.cmdsolutions.com.au/latest-thinking/blogs/how-to-set-up-a-local-kubernetes-cluster-with-minikube-for-local-development-on-macos/
  services.dnsmasq = {
    enable = false;
    # addresses = {
    #   test = "127.0.0.1";
    #   local = "127.0.0.1";
    # };
  };

  #  networking.dns = mkOption {
  #     type = types.listOf types.str;
  #     default = [];
  #     example = [ "8.8.8.8" "8.8.4.4" "2001:4860:4860::8888" "2001:4860:4860::8844" ];
  #     description = "The list of dns servers used when resolving domain names.";
  #   };


  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      # upgrade = true;
    };
    casks = [
      "adobe-digital-editions" # library epub reader
      "alt-tab" # alternative switcher
      "arduino-ide"
      "bankid"
      "blender"
      "calibre"
      "cardinal"
      "digikam"
      "discord"
      "eloston-chromium"
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
      "microsoft-teams"
      "mockoon"
      "nordvpn"
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
      # "skype"
      # "openshot-video-editor" # no good - couldn't do custom resolution or match input…?
      # "virtualbox" # no arm yet
      # TODO kmonad https://gist.github.com/amiorin/4c74f63fe599a1dcbd0933628df1aac9
    ];
    taps = [
      "chipmk/tap"
      "datawire/blackbird"
      "oven-sh/bun"
      "wez/wezterm"
      # "nikitabobko/tap"
    ];
    brews = [
      "awscli"
      "bun"
      "datawire/blackbird/telepresence-arm64"
      "gitlab-ci-local"
      "gmsh" # To view stl's
      "helm"
      "k3sup"
      # "koekeishiya/formulae/skhd"
      # "koekeishiya/formulae/yabai"
      "kubernetes-cli"
      "mas" # mac app store
      "mkcert" # create self-signed certs for dev env
      "nss" # to install certs into FF and Java with certutil
      "pinentry-mac" # gpg
      "wimlib" # To split windows iso files > 4GB for bootable USB
      # "chipmk/tap/docker-mac-net-connect"
      # hopefylle replaced by teleprecense
      ];
    masApps = {
      logic = 634148309;
      iordning = 1157906903;
      tailscale = 1475387142;
    };
  };

  programs = {
    # direnv = {
    #     enable = true;
    #     nix-direnv.enable = true;
    # };
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true;
    fish = {
        enable = true;
        shellInit =
        ''
            alias dr="darwin-rebuild switch --flake path:$HOME/dev/dotfiles/nix#(scutil --get LocalHostName)"
            alias dr:update="nix flake update path:$HOME/dev/dotfiles/nix"
            # Nix
            if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
            # echo 'bootstrapping Nix from nix-darwin'
            replay source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
            end

            # nix-darwin
            if test -e '/etc/static/bashrc'
            # echo '/etc/static/bashrc from nix-darwin'
            replay source '/etc/static/bashrc'
            end

            # home-manager, needed even though plugin from nix-darwin
            if test -e '/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh'
            # echo 'source hm-session-vars'
            replay source '/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh'
            end

            # order paths so that nix is before built-ins https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1030877541
            fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
        '';
    };
  };

  # adds shells to /ets/shells so I can use fish
  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # system.defaults.dock = {
  #   autohide = true;
  #   autohide-delay = 0.0;
  #   tilesize = 200;
  #   orientation = "left";
  # };


  # Iterate testing
  #  defaults delete com.apple.dock or nix-darwin rebuild
  # killall Dock
  # if it doesn't come back - something wrong with settings


  system.defaults.CustomUserPreferences = {
    # defaults domains - to list domains
    # defaults read _domain_ to show settings
    # Then stick stuff here:
    "com.apple.dock" = {
      autohide = 1;
      tilesize = 20;
      # otherwise sbt bsp makes kitty icon bounce on each scala source file save.
      # better solution?
      no-bouncing = true;
    };

    # Try to see if I can find a way to do this:
    # keyboard -> inputsources -> keyboard shortcuts, uncheck ctrl-space used for switching input source.
    # This is used for triggerSuggestion in vscode for instance
  };


  # system.defaults.dock.orientation = "left";

  # To activate settings according to https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236#i
  # but did not work for dock, see above
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Decoupled home-manager - can be used from nixos as well
  users.users.viktor = {
    name = "viktor";
    home = "/Users/viktor";
  };

}
