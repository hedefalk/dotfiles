# New Mac?

## Prerequisites

Install nix and homebrew. Homebrew is managed by nix-darwin, but it still needs to be installed. Also need Rosetta for just a couple of things (adobe-digital-editions for lending library books). Not gonna chase it since I need Rosetta for container stuff anyways.

    sh <(curl -L https://nixos.org/nix/install)

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    sudo softwareupdate --install-rosetta

## Use this repo

1. Clone the repo

        git clone https://github.com/hedefalk/dotfiles.git
        cd dotfiles

1. Add a machine config in the main flake.nix and match it with the LocalHostName or any other means. I'm using LocalHostName like this:

        nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-24.22#darwin-rebuild switch --flake path:$HOME/dev/dotfiles/#(scutil --get LocalHostName)

LocalHostName is a main entry in [flake.nix](flake.nix).


With that run I have access to all my cli tools as well as almost _all_ ui apps via homebrew casks.



3) Create a gpg key

    gpg --full-generate-key

    darwin-rebuild switch --flake path:$HOME/dev/dotfiles/nix#(scutil --get LocalHostName)
