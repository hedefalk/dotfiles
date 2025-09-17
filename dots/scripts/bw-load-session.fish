#!/usr/bin/env fish

# Set Bitwarden session from macOS keychain
function set_bw_session
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

    # Try to get the Bitwarden session from keychain
    set session_token (security find-generic-password -a "$USER" -s "bitwarden-session" -w 2>/dev/null)

    if test $status -eq 0; and test -n "$session_token"
        set -gx BW_SESSION $session_token
        echo $BW_SESSION
        echo "Bitwarden session set successfully"
        return 0
    else
        echo "Failed to retrieve Bitwarden session from keychain"
        echo "Make sure you have stored the session token with:"
        echo "security add-generic-password -a \"\$USER\" -s \"bitwarden-session\" -w \"your_session_token\""
        return 1
    end
end

# Check if script is being sourced or executed
if status is-interactive
    # Being sourced - call the function to set BW_SESSION in current shell
    set_bw_session
else
    # Being executed - provide instructions
    echo "This script sets BW_SESSION in the current shell."
    echo "To use it, you must source it:"
    echo "  source bw-session.fish"
    echo ""
    echo "Or add it to your shell configuration to run automatically."
    exit 1
end
