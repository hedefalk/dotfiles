{ pkgs, lib, ... }:

{
  # Development-focused profile with tools currently in use

  environment.systemPackages = with pkgs; [
    # Development environments and tools
    devenv
    act # local GitHub actions

    # Language servers and development support
    nixd # nix language server
    
    # Infrastructure and deployment
    ansible
    
    # Container and virtualization
    docker
    colima
    
    # Kubernetes ecosystem
    kubectl
    k9s
    kind
    k3sup
    kubeswitch
    
    # Version control and collaboration
    git-filter-repo
    gitlab-ci-local
    glab # GitLab CLI
    github-cli
    lazygit
    
    # Security and certificates
    certbot
    mkcert
    
    # Language runtimes and package managers
    bun
    deno
    
    # Network debugging
    grpcurl
    
    # Text processing
    jq
  ];

  # Development-specific Homebrew packages
  homebrew = {
    casks = [
      # Development tools
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

  # Development-specific environment variables
  environment.variables = {
    # Development tool configuration
    DOCKER_DEFAULT_PLATFORM = "linux/amd64";
  };
}