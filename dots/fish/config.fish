# the UTF-8 is important for tmux to show special chars
# can also run tmux with -u
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -U fish_greeting ""

# Homebrew on M1
if test -e '/opt/homebrew/bin/brew'
  eval (/opt/homebrew/bin/brew shellenv)
end

# brew doesn't need to update _all_ the time
set -x HOMEBREW_NO_AUTO_UPDATE true

# Prompt
starship init fish | source

# Rust path
# set PATH $HOME/.cargo/bin $PATH


# kubectl alias
abbr --add k kubectl
set -x KUBE_EDITOR "zed --wait"

#gcloud
# [ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc" ]; and source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
[ -s "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc" ]; and source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"


# alias ssh in kitty
if test "$TERM" = "xterm-kitty"
  # alias ssh="kitty +kitten ssh"
  alias s="kitty +kitten ssh"
end

# removed because this is something for iTerm2 that I don's use?
# alias ls gls

function cppass --wraps pass
  pass $argv | tr -d '\n' | pbcopy
end

function ll --wraps ls
   ls -lh --time-style="+%Y-%m-%d" $argv
end

# if test (hostname) = "antonida"; and test -e 'hackintosh.fish'
#   source 'hackintosh.fish'
# end

# Make SSH use GPG
if status --is-login
  gpgconf --launch gpg-agent
end

# set -e SSH_AGENT_PID
# if not set -q gnupg_SSH_AUTH_SOCK_by
# or test $gnupg_SSH_AUTH_SOCK_by -ne %self
#     set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
# end
# # Need to set tty to current tty to be able to enter passphrase
# set -x GPG_TTY (tty)

set -e SSH_AGENT_PID
if test -z $gnupg_SSH_AUTH_SOCK_BY; or test $gnupg_SSH_AUTH_SOCK_BY -ne $fish_pid
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
set -gx GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# TODO: Check
# https://gist.github.com/mcattarinussi/834fc4b641ff4572018d0c665e5a94d3?permalink_comment_id=4159058#gistcomment-4159058
# gpgconf --launch gpg-agent
# set -e SSH_AUTH_SOCK
# set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# https://unix.stackexchange.com/questions/280879/how-to-get-pinentry-curses-to-start-on-the-correct-tty
gpg-connect-agent updatestartuptty /bye >/dev/null

# If GPG doesn't work, kill and restart agent.
# gpgconf --kill gpg-agent
# gpgconf --launch gpg-agent
# or rerun block above

if not type -q tailscale
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
end

if not type -q dotfiles
    alias dotfiles="$EDITOR ~/dev/dotfiles"
end

# direnv
set -x DIRENV_LOG_FORMAT "" # Remove verbosity https://github.com/direnv/direnv/issues/68
direnv hook fish | source # direnv is in home-manager

# fish with nix-shell
# https://github.com/haslersn/any-nix-shell/tree/master/bin
# I'll put this last
# any-nix-shell fish --info-right | source

# https://www.reddit.com/r/fishshell/comments/104cypt/is_there_any_setting_for_history_auto_merge/
if not set --query fish_private_mode
  history merge
end

# Personal scripts
set -x PATH "$HOME/scripts:$PATH"

# Coursier binaries
set -x PATH $PATH $HOME/Library/Application\ Support/Coursier/bin

# Don't show extra prompt
set -U devbox_no_prompt true
