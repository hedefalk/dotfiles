{pkgs, config, self, ...}:
  let
       # Get the absolute path of the flake directory
       flakePath = toString self.outPath;
       # Define dotfiles directory relative to the flake
       dotfilesPath = "${flakePath}/dots"; # If dotfiles is a subdirectory in your flake
  in {
    home.username = "viktor";
    home.homeDirectory = pkgs.lib.mkForce (
        if pkgs.stdenv.isLinux
        then "/home/viktor"
        else "/Users/viktor"
    );

    home.sessionVariables = {
        EDITOR = "zed";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs;
        [
        jq
        devbox
        bashInteractive
        ]
        ++ (
        if pkgs.stdenv.isLinux
        # then [gcc coreutils libstdcxx5 xclip unixtools.ifconfig inotify-tools ncurses5]
        then []
        else []
        );

    programs = {
        fish = {
            enable = true;
        };

        starship = {
            enable = true;
        };

        nushell = {
            enable = true;
        };
    };

    home.file = {
        ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fish";
        ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}//wezterm";
        # ".config/zed/themes".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fish/.config/zed/themes";
        ".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/zed/settings.json";
        ".config/zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/zed/keymap.json";
        ".config/git/config".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/git/.gitconfig";
        ".gitignore".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/git/.gitignore";
    };

    programs.home-manager.enable = true;
    }
