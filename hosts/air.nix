{ pkgs, ... }:

{
  # imports = [ <home-manager/nix-darwin> ];
  nixpkgs.hostPlatform    = "aarch64-darwin";
  environment.systemPackages = with pkgs; [
    # monkeysphere  # not supported on ‘aarch64-darwin
    any-nix-shell
  ];

  programs = {
  };
}
