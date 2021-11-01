# --- Exports ---
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=vim
export LANG=en_US.UTF-8
export FZF_DEFAULT_OPTS="--extended"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export SDKMAN_DIR="$HOME/.sdkman"
export PYENV_ROOT="$HOME/.pyenv"

# PATH
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.symfony/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export WRK="$HOME/Workspace"

# --- Aliases ---
alias ls="exa"
alias cp="cp -i"
alias rm="rm -i"
alias v="vim"
alias fd="fdfind"
