# .zshrc — interactive shell config
# No frameworks (no oh-my-zsh). Lean, fast, and explicit.

BREW_PREFIX="$(brew --prefix)"

# ============================================================
# Plugins (installed via brew)
# brew install zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
# ============================================================
if [[ -d "$BREW_PREFIX/share/zsh-autosuggestions" ]]; then
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

if [[ -d "$BREW_PREFIX/share/zsh-syntax-highlighting" ]]; then
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# ============================================================
# Options
# ============================================================
setopt AUTO_CD               # just type a directory name to cd into it
setopt CORRECT               # suggest corrections for typos
setopt GLOB_DOTS             # include dotfiles in globs
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB          # case-insensitive globbing
setopt INTERACTIVE_COMMENTS  # allow comments in interactive shell
setopt SHARE_HISTORY         # share history between all sessions
setopt HIST_IGNORE_DUPS      # no duplicate history entries
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE     # don't record commands starting with a space
setopt HIST_VERIFY           # show substituted history command before running
setopt HIST_REDUCE_BLANKS

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# ============================================================
# Completion
# ============================================================
autoload -Uz compinit
# Only rebuild completion dump once a day
if [[ -n "$HOME/.zcompdump" ]] && [[ $(date +'%j') != $(stat -f '%Sm' -t '%j' "$HOME/.zcompdump" 2>/dev/null) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Use Homebrew's zsh completions if available
if [[ -d "$BREW_PREFIX/share/zsh-completions" ]]; then
  fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)
fi

# ============================================================
# Key bindings (vi mode)
# ============================================================
bindkey -v
export KEYTIMEOUT=1  # reduce mode switch delay to 10ms

# Make Ctrl-p/n work in vi insert mode
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^f' forward-char  # accept autosuggestion one char at a time

# Cursor shape: block for normal mode, beam for insert
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # block
  else
    echo -ne '\e[5 q'  # beam
  fi
}
zle -N zle-keymap-select
echo -ne '\e[5 q'  # beam on startup
preexec() { echo -ne '\e[5 q'; }

# ============================================================
# fzf — fuzzy finder
# ============================================================
if command -v fzf &>/dev/null; then
  # fzf key bindings and completions
  if [[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  fi
  if [[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ]]; then
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
  fi

  # Use fd for fzf (respects .gitignore, faster than find)
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
  fi

  # Catppuccin Mocha colors for fzf
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --multi --height=50% --layout=reverse --border=rounded \
    --preview-window=right:60%:hidden --bind=ctrl-/:toggle-preview"
fi

# ============================================================
# PATH additions
# ============================================================
# Homebrew — must come first, before system /usr/bin
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Node version manager (fnm)
eval "$(fnm env --use-on-cd)"

# Bun
if [[ -d "$HOME/.bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
fi

# pnpm
if [[ -d "$HOME/Library/pnpm" ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi

# ============================================================
# AI
# ============================================================
# Limit Ollama to 6 CPU threads max
export OLLAMA_NUM_THREADS=6

# Cap GPU layers (lower = less heat, more CPU fallback)
export OLLAMA_NUM_GPU=1

# ============================================================
# Aliases
# ============================================================

# Modern replacements
alias ls='ls --color=auto'
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first --git'
  alias la='eza -la --icons --group-directories-first --git'
  alias tree='eza --tree --icons --git-ignore'
else
  alias ll='ls -lhF'
  alias la='ls -lahF'
fi

if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias less='bat --paging=always'
fi

if command -v rg &>/dev/null; then
  alias grep='rg'
fi

# Editor shortcuts
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias glog='git log --oneline --decorate --graph'
alias gdiff='git diff'

# tmux shortcuts
alias t='tmux'
alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'

# Misc
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias path='echo ${PATH//:/\\n}'  # print PATH one entry per line
alias reload='source ~/.zshrc && echo "Shell reloaded"'

# Quick edit dotfiles
alias dot='cd ~/.dotfiles'
alias zshconfig='nvim ~/.dotfiles/zsh/.zshrc'
alias nvimconfig='nvim ~/.dotfiles/nvim/.config/nvim'
alias tmuxconfig='nvim ~/.dotfiles/tmux/.tmux.conf'

# Open WebUI
alias webui='DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve'

# ============================================================
# Functions
# ============================================================

# Create a directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Search and cd into a directory with fzf
fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git --exclude node_modules . "${1:-.}" 2>/dev/null | fzf +m) && cd "$dir"
}

# Open files with fzf + nvim
vf() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim "${files[@]}"
}

# Quick git worktree (useful for reviewing PRs without stashing)
gwt() {
  local branch="${1:?Usage: gwt <branch>}"
  git worktree add "../$(basename "$PWD")-${branch}" "$branch"
}

# ============================================================
# Dev layout: nvim | terminal + terminal
# Usage: dev [path]   — opens a 3-pane tmux layout in the given path
# ============================================================
dev() {
  local target="${1:-.}"
  local session="dev"

  # If we're already inside tmux, create a new window instead
  if [[ -n "$TMUX" ]]; then
    tmux new-window -c "$target" -n "dev"
    # Left pane: nvim
    tmux send-keys "nvim ." Enter
    # Right pane: terminal
    tmux split-window -h -l 20% -c "$target"
    # Focus back on nvim (left pane)
    tmux select-pane -L
  else
    # Create a fresh session
    tmux new-session -d -s "$session" -c "$target"
    # Left pane: nvim
    tmux send-keys -t "$session" "nvim ." Enter
    # Right pane: terminal
    tmux split-window -h -t "$session" -l 20% -c "$target"
    # Focus nvim
    tmux select-pane -t "$session" -L
    tmux attach-session -t "$session"
  fi
}

# ============================================================
# Prompt — Starship
# ============================================================
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# opencode
export PATH=/Users/pandora/.opencode/bin:$PATH
