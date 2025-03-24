{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
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

    starship = {
      enable = true;
    };

    nushell = {
      enable = true;
    };
  };

  programs.home-manager.enable = true;
}
