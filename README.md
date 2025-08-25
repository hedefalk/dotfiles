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

2. Add a machine config in the main flake.nix and match it with the LocalHostName or any other means. I'm using LocalHostName like this:

        nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake path:$HOME/dotfiles/#$(scutil --get LocalHostName)

LocalHostName is a main entry in [flake.nix](flake.nix).


3. Still need to

        chsh -s /run/current-system/sw/bin/fish



With that run I have access to all my cli tools as well as almost _all_ ui apps via homebrew casks.



4) Create a gpg key

    gpg --full-generate-key

    Do not fill out "comment" because git wont match then, it matches verbatim:

          [user]
             	name = Viktor Hedefalk
              email = hedefalk@gmail.com

    Probably can fix that if I want specific named/commented gpg keys, but I'm ok with the same name.


5) Push this public key up to github as a signing key


        gh auth login // no ssh keys
        gh auth refresh -h github.com -s admin:gpg_key

        set KEY_ID (gpg --list-secret-keys --keyid-format=long | grep sec | head -n 1 | string replace -r '.*\/([A-F0-9]+) .*' '$1'); and \
              gpg --armor --export $KEY_ID > /tmp/github_gpg_key.asc; and \
              gh api --method POST \
                -H "Accept: application/vnd.github+json" \
                /user/gpg_keys \
                -F "armored_public_key=@/tmp/github_gpg_key.asc"; and \
              rm /tmp/github_gpg_key.asc

        git remote set-url origin git@github.com:hedefalk/dotfiles.git
        git push

        // Still not working ? ^

6) Also need to add an auth subkey and then push that up to github as an SSH key for authentication:


    gpg --expert --edit-key YOUR_KEY_ID

Choose (8), remove signing and encryption and just enable authentication, quit, choose 4096 bits and save.


Upload to github:

    gpg --export-ssh-key $(gpg --list-secret-keys --with-colons | awk -F: '/^ssb.*a/ {print $5}' | head -1) | gh ssh-key add - --title "M4 Air GPG SSH Key"


Will need to authorize the cli to do this with the browser so could of course opt to not to it directly with browser.
