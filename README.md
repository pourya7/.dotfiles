# .dotfiles

Personal dotfiles for a senior full-stack engineer (JS/Python) on macOS.
Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

| Tool | Purpose |
|------|---------|
| **NeoVim** + [LazyVim](https://lazyvim.github.io) | Primary editor |
| **tmux** | Terminal multiplexer |
| **zsh** | Shell (no framework, just plugins) |
| **Starship** | Cross-shell prompt |
| **Claude Code** | AI coding agent |
| **Playwright MCP** | Browser automation for AI agents |
| **Homebrew** | Package manager |
| **GNU Stow** | Symlink manager |

## Directory structure

```
.dotfiles/
├── nvim/                   # NeoVim (LazyVim)
│   └── .config/nvim/
│       ├── init.lua
│       └── lua/
│           ├── config/     # options, keymaps, autocmds, lazy bootstrap
│           └── plugins/    # colorscheme, editor, lang extras, ui tweaks
├── tmux/
│   └── .tmux.conf          # Catppuccin Mocha + vi-keys + TPM
├── zsh/
│   ├── .zshrc              # Interactive shell (plugins, aliases, functions)
│   └── .zshenv             # Environment vars (sourced for all sessions)
├── starship/
│   └── .config/starship.toml   # Catppuccin Mocha prompt
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── claude/
│   └── .config/claude/
│       ├── CLAUDE.md       # Global context loaded by Claude Code
│       └── mcp-setup.sh    # Register MCP servers (run once)
├── setup.sh                # Full bootstrap script
├── .gitignore
└── README.md
```

## Fresh install (new machine)

```bash
# 1. Clone the repo
git clone git@github.com:pourya7/.dotfiles.git ~/.dotfiles

# 2. Run the bootstrap script
cd ~/.dotfiles
chmod +x setup.sh
./setup.sh
```

The script will:
- Install Homebrew if missing
- Install all required packages via brew
- Back up any conflicting existing dotfiles
- Stow all modules (creates symlinks in `$HOME`)
- Install TPM (tmux plugin manager)
- Bootstrap LazyVim (headless nvim run)
- Register Playwright MCP for Claude Code

## Manual stow

To stow/unstow individual modules:

```bash
cd ~/.dotfiles

stow nvim          # create symlinks for nvim config
stow tmux          # create symlinks for tmux config
stow -D nvim       # remove nvim symlinks (unstow)
stow -R nvim       # restow (unstow + stow again)
```

## Post-install checklist

- [ ] Restart terminal (or `source ~/.zshrc`)
- [ ] In tmux: press `Ctrl-Space + I` to install tmux plugins
- [ ] Open `nvim` — LazyVim finishes installing on first launch
- [ ] Run `claude mcp list` to verify Playwright MCP is registered
- [ ] Install a [Nerd Font](https://www.nerdfonts.com/) in iTerm2 (e.g., JetBrainsMono Nerd Font)

## NeoVim highlights

- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) via LazyVim
- **Language support**: TypeScript, Python, JSON, YAML, Tailwind, Markdown, Docker
- **Completion**: nvim-cmp + LSP (Mason handles server installs)
- **Fuzzy finding**: Telescope
- **File tree**: neo-tree
- **Git**: gitsigns (inline blame), LazyGit integration
- **Quick file nav**: [Harpoon v2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
- **tmux integration**: vim-tmux-navigator (Ctrl-hjkl across panes)
- **Colorscheme**: Catppuccin Mocha

Key mappings (on top of LazyVim defaults):

| Key | Action |
|-----|--------|
| `<leader>ha` | Harpoon: add file |
| `<leader>hh` | Harpoon: toggle menu |
| `<leader>h1-4` | Harpoon: jump to file 1–4 |
| `jk` / `kj` | Exit insert mode |
| `Ctrl-s` | Save file |
| `Ctrl-d/u` | Scroll + center cursor |

## tmux highlights

- **Prefix**: `Ctrl-Space`
- **Theme**: Catppuccin Mocha
- **Splits**: `Prefix + |` (horizontal), `Prefix + -` (vertical)
- **Navigate panes**: `Ctrl-hjkl` (shared with NeoVim)
- **Copy mode**: `v` to select, `y` to copy to macOS clipboard
- **Session save/restore**: tmux-resurrect + tmux-continuum (auto)

## Claude Code + Playwright MCP

The Playwright MCP gives Claude Code a real browser it can control — navigate, click, fill forms, take screenshots. This is the equivalent of what Antigravity does for browser testing.

```bash
# Register (already done by setup.sh, but if you need to redo it):
claude mcp add playwright -- npx @playwright/mcp@latest

# Verify
claude mcp list
```

Once registered, you can ask Claude Code things like:
- *"Open localhost:3000 and test the login flow"*
- *"Navigate to the signup page and fill out the form with test data"*
- *"Take a screenshot of the dashboard and tell me if there are any layout issues"*

## Updating

```bash
cd ~/.dotfiles
git pull

# Re-stow if structure changed
stow -R nvim tmux zsh git starship claude
```

## Tools installed by setup.sh

| Tool | Description |
|------|-------------|
| neovim | Editor |
| tmux | Terminal multiplexer |
| stow | Symlink manager |
| git-delta | Better git diffs |
| starship | Shell prompt |
| fzf | Fuzzy finder |
| eza | Modern `ls` |
| bat | Modern `cat` |
| ripgrep | Modern `grep` (used by Telescope) |
| fd | Modern `find` (used by fzf/Telescope) |
| lazygit | TUI git client |
| zsh-autosuggestions | Fish-like autosuggestions |
| zsh-syntax-highlighting | Fish-like syntax highlighting |
