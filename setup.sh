#!/usr/bin/env bash
# =============================================================================
# setup.sh — Bootstrap dotfiles on a new (or existing) macOS machine
# =============================================================================
# Usage:
#   chmod +x setup.sh && ./setup.sh
#
# What it does:
#   1. Checks for / installs Homebrew
#   2. Installs required tools (nvim, tmux, stow, etc.)
#   3. Backs up any existing conflicting dotfiles
#   4. Runs stow for each module
#   5. Installs NeoVim plugins (lazy.nvim → LazyVim)
#   6. Installs tmux plugin manager (TPM)
#   7. Registers Claude Code MCP servers
# =============================================================================

set -euo pipefail

# ---- Colors ----
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info() { echo -e "${BLUE}→${NC} $*"; }
success() { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC}  $*"; }
error() {
  echo -e "${RED}✗${NC} $*"
  exit 1
}
header() { echo -e "\n${BOLD}$*${NC}\n$(printf '─%.0s' {1..50})"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# =============================================================================
# 1. Homebrew
# =============================================================================
header "Homebrew"
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for this session (Apple Silicon)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  success "Homebrew installed"
else
  success "Homebrew already installed"
fi

# =============================================================================
# 2. Install packages
# =============================================================================
header "Installing packages"

BREW_PACKAGES=(
  # Core tools
  neovim    # the main editor
  tmux      # terminal multiplexer
  stow      # symlink manager for dotfiles
  git       # version control
  git-delta # better git diffs

  # Shell enhancements
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  starship # cross-shell prompt
  fzf      # fuzzy finder

  # Modern CLI replacements
  eza     # modern ls
  bat     # modern cat (with syntax highlighting)
  ripgrep # modern grep (used by telescope in nvim)
  fd      # modern find (used by fzf/telescope)
  lazygit # TUI git client (integrates with LazyVim)

  # Dev tools
  python3 # Python
  pyenv   # Python version manager
)

info "Installing brew packages..."
for pkg in "${BREW_PACKAGES[@]}"; do
  if brew list --formula "$pkg" &>/dev/null 2>&1; then
    echo "  [skip] $pkg (already installed)"
  else
    echo "  [install] $pkg"
    brew install "$pkg" 2>/dev/null || warn "Failed to install $pkg (non-fatal)"
  fi
done
success "Packages installed"

# Install fzf shell integration
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish 2>/dev/null || true
fi

# =============================================================================
# 3. Backup conflicting dotfiles
# =============================================================================
header "Backing up existing dotfiles"

STOW_MODULES=(nvim tmux zsh git starship claude)
SHOULD_BACKUP=false

for module in "${STOW_MODULES[@]}"; do
  # Dry-run stow to find conflicts
  conflicts=$(stow --dir="$DOTFILES_DIR" --target="$HOME" --no-folding -n "$module" 2>&1 | grep "^  \* " || true)
  if [[ -n "$conflicts" ]]; then
    SHOULD_BACKUP=true
    break
  fi
done

if [[ "$SHOULD_BACKUP" == true ]]; then
  mkdir -p "$BACKUP_DIR"
  info "Backing up conflicting files to $BACKUP_DIR"

  # Files that stow will conflict with
  FILES_TO_BACKUP=(
    .zshrc .zshenv .zlogin .zlogout .zprofile
    .tmux.conf
    .gitconfig .gitignore_global
    .config/nvim
    .config/starship.toml
    .config/claude/CLAUDE.md
  )

  for f in "${FILES_TO_BACKUP[@]}"; do
    src="$HOME/$f"
    if [[ -e "$src" ]] || [[ -L "$src" ]]; then
      dest="$BACKUP_DIR/$f"
      mkdir -p "$(dirname "$dest")"
      mv "$src" "$dest" 2>/dev/null && echo "  backed up: $f" || true
    fi
  done
  success "Backup complete: $BACKUP_DIR"
else
  success "No conflicts found, no backup needed"
fi

# =============================================================================
# 4. Stow modules
# =============================================================================
header "Stowing dotfiles"

for module in "${STOW_MODULES[@]}"; do
  if [[ -d "$DOTFILES_DIR/$module" ]]; then
    info "Stowing $module..."
    stow --dir="$DOTFILES_DIR" --target="$HOME" --no-folding "$module" 2>&1 &&
      success "$module" ||
      warn "  $module had issues (check manually)"
  else
    warn "$module directory not found, skipping"
  fi
done

# =============================================================================
# 5. tmux plugin manager (TPM)
# =============================================================================
header "tmux Plugin Manager"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
  success "TPM already installed"
else
  info "Installing TPM..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
  success "TPM installed"
fi

info "Run  'tmux source ~/.tmux.conf'  then press  'Prefix + I'  to install tmux plugins"

# =============================================================================
# 6. NeoVim — LazyVim bootstrap
# =============================================================================
header "NeoVim / LazyVim"

info "LazyVim will auto-install on first nvim launch."
info "Opening nvim to trigger bootstrap (this may take a minute)..."

# Run nvim headlessly to install plugins
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
success "LazyVim bootstrap complete (or already done)"

# =============================================================================
# 7. Claude Code MCP — Playwright
# =============================================================================
header "Claude Code MCP"

if command -v claude &>/dev/null; then
  info "Registering Playwright MCP server..."
  claude mcp add playwright -- npx @playwright/mcp@latest 2>/dev/null &&
    success "Playwright MCP registered" ||
    warn "Playwright MCP registration failed (run manually: claude mcp add playwright -- npx @playwright/mcp@latest)"
else
  warn "claude CLI not found. Install Claude Code first: https://claude.ai/download"
  warn "Then run: bash $DOTFILES_DIR/claude/.config/claude/mcp-setup.sh"
fi

# =============================================================================
# Done
# =============================================================================
header "Setup complete!"

cat <<EOF
${GREEN}Your dotfiles are now active.${NC}

Next steps:
  1. Restart your terminal (or run: source ~/.zshrc)
  2. Open tmux and press ${BOLD}Prefix + I${NC}  (Ctrl-Space + I) to install tmux plugins
  3. Open nvim — LazyVim will finish installing on first launch
  4. If Claude Code was not found: install it, then run:
       bash ~/.dotfiles/claude/.config/claude/mcp-setup.sh

Useful reminders:
  • Dotfiles live at:  ~/.dotfiles
  • Edit zsh config:  nvim ~/.dotfiles/zsh/.zshrc
  • Edit nvim config: nvim ~/.dotfiles/nvim/.config/nvim
  • Edit tmux config: nvim ~/.dotfiles/tmux/.tmux.conf
  • Re-run stow:      cd ~/.dotfiles && stow <module>
  • Backup was saved: ${BACKUP_DIR:-"(no backup needed)"}

EOF
