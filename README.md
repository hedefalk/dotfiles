# New Mac?

1. Install nix and homebrew. Homebrew is managed by nix-darwin, but it still needs to be installed.

    sh <(curl -L https://nixos.org/nix/install)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

1. Clone this repo

    git clone https://github.com/hedefalk/dotfiles.git
    cd dotfiles

1. Add a machine config in the main flake.nix and match it with the LocalHostName or any other means. I'm using LocalHostName.

    nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-24.22#darwin-rebuild switch --flake path:$HOME/dev/dotfiles/#(scutil --get LocalHostName)









*) Create a gpg key

    gpg --full-generate-key


    darwin-rebuild switch --flake path:$HOME/dev/dotfiles/nix#(scutil --get LocalHostName)
