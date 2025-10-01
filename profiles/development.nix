{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    devenv
    act # local GitHub actions
    nixd # nix language server
    ansible
    docker
    colima
    # Kubernetes ecosystem
    kubectl
    k9s
    kind
    k3sup
    kubeswitch
    git-filter-repo
    gitlab-ci-local
    glab # GitLab CLI
    github-cli
    lazygit
    certbot
    mkcert
    bun
    deno
    grpcurl
    jq
  ];

  # Development-specific Homebrew packages
  homebrew = {
    casks = [
      "mockoon"
      "intellij-idea-ce"
    ];

    brews = [
      # Development CLI tools
      "datawire/blackbird/telepresence-arm64"
      "gitlab-ci-local"
      "helm"
      "kubernetes-cli"
      "awscli"
    ];

    taps = [
      "datawire/blackbird"
    ];
  };

  environment.variables = {
  };
}
