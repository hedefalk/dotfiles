{  pkgs, ... }:

# Shared nixos and mac
{
    programs = {
        direnv = {
            enable = true;
            nix-direnv.enable = true;
        };
    };

    environment.variables = {
      EDITOR = "zed --wait";
      VISUAL = "zed --wait";
    };

    environment.systemPackages = with pkgs; [
        # nix-direnv
        # nerdctl
        # bitwarden-cli
        certbot
        deno
        fish
        fishPlugins.fzf
        fishPlugins.z
        fzf
        git-filter-repo
        gitlab-ci-local
        glab # gitlab cli
        micro # editor
        nil # nix lang-server
        yazi
    ];

}
