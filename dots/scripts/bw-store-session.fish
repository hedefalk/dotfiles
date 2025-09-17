#!/usr/bin/env fish

# Store Bitwarden session in macOS keychain
function store_bw_session
    # Check if we're on macOS
    if test (uname) != "Darwin"
        echo "This script is only for macOS"
        return 1
    end

    # Check if security command exists
    if not type -q security
        echo "security command not found. This script requires macOS."
        return 1
    end

    # Check if bw command exists
    if not type -q bw
        echo "bw command not found. Please install Bitwarden CLI."
        return 1
    end

    echo "Unlocking Bitwarden and storing session in keychain..."

    # Get session token from bw unlock
    set session_token (bw unlock --raw)
    set unlock_status $status

    if test $unlock_status -ne 0
        echo "Failed to unlock Bitwarden. Please check your master password."
        return 1
    end

    if test -z "$session_token"
        echo "No session token received from Bitwarden unlock."
        return 1
    end

    # Check if keychain entry already exists
    security find-generic-password -a "$USER" -s "bitwarden-session" >/dev/null 2>&1
    set find_status $status

    if test $find_status -eq 0
        echo "Existing Bitwarden session found in keychain. Updating..."
        # Delete existing entry
        security delete-generic-password -a "$USER" -s "bitwarden-session" 2>/dev/null
        if test $status -ne 0
            echo "Warning: Failed to delete existing keychain entry. Attempting to add anyway..."
        end
    end

    # Add new session token to keychain
    security add-generic-password -a "$USER" -s "bitwarden-session" -w "$session_token"
    set add_status $status

    if test $add_status -eq 0
        echo "Bitwarden session successfully stored in keychain!"
        echo "You can now use 'source bw-session.fish' to load the session."
        return 0
    else
        echo "Failed to store Bitwarden session in keychain."
        return 1
    end
end

# Check if script is being sourced or executed
if status is-interactive
    # Being sourced - call the function
    store_bw_session
else
    # Being executed - call the function directly
    store_bw_session
end