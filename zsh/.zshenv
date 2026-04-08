# .zshenv — sourced for ALL zsh sessions (login, interactive, scripts)
# Keep this FAST and MINIMAL: only export env vars that must be visible everywhere.

# XDG base dirs (tools increasingly respect these)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Pager
export PAGER="less"
export LESS="-R --use-color"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Homebrew (Apple Silicon path)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
