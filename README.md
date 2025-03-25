# New Mac?

*) Install nix
    sh <(curl -L https://nixos.org/nix/install)

*) Create a gpg key
gpg --full-generate-key


darwin-rebuild switch --flake path:$HOME/dev/dotfiles/nix#(scutil --get LocalHostName)
darwin-rebuild switch --flake path:$HOME/dev/dotfiles2/flake#(scutil --get LocalHostName)
