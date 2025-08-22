#!/usr/bin/env fish

# Find the keygrip of your GPG authentication key
function add_gpg_keygrip_to_sshcontrol
    # Get the key ID first
    set key_id (gpg --list-secret-keys --keyid-format=long | grep sec | head -n 1 | string replace -r '.*\/([A-F0-9]+) .*' '$1')

    if test -z "$key_id"
        echo "No GPG key found. Please check if you have a GPG key."
        return 1
    end

    echo "Found GPG key: $key_id"

    # Get the keygrip
    set keygrip (gpg --with-keygrip -k $key_id | grep Keygrip | head -n 1 | string replace -r '.*Keygrip = ([A-F0-9]+).*' '$1')

    if test -z "$keygrip"
        echo "Could not find keygrip for key $key_id"
        return 1
    end

    echo "Found keygrip: $keygrip"

    # Check if the keygrip is already in sshcontrol
    if test -f ~/.gnupg/sshcontrol
        if grep -q $keygrip ~/.gnupg/sshcontrol
            echo "Keygrip already in ~/.gnupg/sshcontrol"
            return 0
        end
    else
        # Create the file if it doesn't exist
        mkdir -p ~/.gnupg
        touch ~/.gnupg/sshcontrol
        echo "Created ~/.gnupg/sshcontrol file"
    end

    # Add the keygrip to sshcontrol
    echo $keygrip >> ~/.gnupg/sshcontrol

    # Set proper permissions
    chmod 600 ~/.gnupg/sshcontrol

    echo "Successfully added keygrip to ~/.gnupg/sshcontrol"
    echo "You may need to restart gpg-agent with:"
    echo "gpgconf --kill gpg-agent"

    return 0
end

add_gpg_keygrip_to_sshcontrol
