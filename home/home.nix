{pkgs, config, self, lib, ...}:
  let
    homeDirectory = "/Users/viktor";
    dotfilesPath = homeDirectory + "/dotfiles/dots"; # home-manager#2085
       # Get the absolute path of the flake directory
       # flakePath = toString self.outPath;
       # Define dotfiles directory relative to the flake
       # dotfilesPath = "${flakePath}/dots"; # If dotfiles is a subdirectory in your flake
  in {
    home = {
      username = "viktor";
      homeDirectory = homeDirectory;
        # home.homeDirectory = pkgs.lib.mkForce (
        #     if pkgs.stdenv.isLinux
        #     then "/home/viktor"
        #     else "/Users/viktor"
        # );

        file = {
          # ".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fish/config.fish";
          ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/wezterm";
          # ".config/zed/themes".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fish/.config/zed/themes";
          ".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/zed/settings.json";
          ".config/zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/zed/keymap.json";
          ".config/git/config".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/git/.gitconfig";
          ".gitignore".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/git/.gitignore";
          "scripts".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/scripts";
          "./config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/starship.toml";
      };

        sessionVariables = {
            EDITOR = "zed";
        };

        stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
      packages = with pkgs;
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
    };

    programs = {
        fish = {
            enable = true;
            # Instead of using the plugins option, load plugins manually
            interactiveShellInit = ''
              # Load plugins
              # source ${pkgs.fishPlugins.fzf.src}/conf.d/fzf.fish
              # source ${pkgs.fishPlugins.z.src}/conf.d/z.fish

              # My own config.fish
              source ${dotfilesPath}/fish/config.fish;
            '';

            plugins = [
              # {
              #   name = "fzf";
              #   src = pkgs.fishPlugins.fzf.src;
              # }
              # {
              #   name = "z";
              #   src = pkgs.fishPlugins.z.src;
              # }
              {
                name = "replay";
                src = pkgs.fetchFromGitHub {
                    owner = "jorgebucaran";
                    repo = "replay.fish";
                    rev = "d2ecacd3fe7126e822ce8918389f3ad93b14c86c";
                    sha256 = "sha256-TzQ97h9tBRUg+A7DSKeTBWLQuThicbu19DHMwkmUXdg=";
                };
                }
            ];
        };

        starship = {
            enable = true;
        };

        nushell = {
            enable = true;
        };
    };


    programs.home-manager.enable = true;
    }
