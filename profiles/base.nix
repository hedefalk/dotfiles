{ pkgs, lib, ... }:

{
  # Basic Nix configuration
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "viktor" ];
    };
    optimise.automatic = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Basic programs available on all systems
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # Common environment variables
  environment.variables = {
    EDITOR = "zed --wait";
    VISUAL = "zed --wait";
  };

  # Core system packages that should be available everywhere
  environment.systemPackages = with pkgs; [
    # Development essentials
    bun
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

  # System state version
  system.stateVersion = 5;
}
