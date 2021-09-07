# --- Theme ---
ZSH_THEME="spaceship"

# --- General Settings ---
HIST_STAMPS="dd/mm/yyyy" # Date Format
DISABLE_UPDATE_PROMPT=true # Update Automatically
DISABLE_LS_COLORS=true # To not alias ls color

# --- Plugins ---
plugins=(
    docker
    docker-compose
    fd
    git
    mvn
    web-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# --- OH MY ZSH ---
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# --- Load Prompt Theme ---
[ -f "$ZSH_CUSTOM/themes/spaceship-prompt-config.zsh" ] && source "$ZSH_CUSTOM/themes/spaceship-prompt-config.zsh"

# --- Load NVM ---
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# --- Load SDKMAN ---
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# --- Bash auto/tab complete ---
autoload -U compinit && compinit

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# --- Load FZF ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
