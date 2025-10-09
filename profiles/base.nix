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
    diff-so-fancy # git fancy diff
    fish
    fishPlugins.fzf
    fishPlugins.z
    fzf
    git-filter-repo
    gitlab-ci-local
    glab # gitlab cli
    micro # editor
    nodePackages.pnpm
    (pkgs.writeShellScriptBin "claude" ''
      ${pkgs.nodePackages.pnpm}/bin/pnpx @anthropic-ai/claude-code@latest "$@"
    '')
    nil # nix lang-server
    yazi
  ];

  # System state version
  system.stateVersion = 5;
}
