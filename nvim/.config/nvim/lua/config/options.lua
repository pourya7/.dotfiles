-- Options — loaded before plugins
-- LazyVim defaults cover most things; we just override/extend here.

local opt = vim.opt

-- UI
opt.relativenumber = true      -- relative line numbers (muscle memory from vim days)
opt.cursorline = true           -- highlight current line
opt.scrolloff = 8               -- keep 8 lines above/below cursor
opt.sidescrolloff = 8
opt.wrap = false                -- no soft wrap
opt.colorcolumn = "100"         -- soft ruler for wide files
opt.signcolumn = "yes"          -- always show sign column (no layout shift)
opt.conceallevel = 2            -- hide markup in markdown/org files

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Files
opt.undofile = true             -- persistent undo
opt.swapfile = false
opt.backup = false
opt.autowrite = true            -- auto save before :make, etc.

-- Search
opt.ignorecase = true
opt.smartcase = true            -- case-sensitive if pattern has uppercase

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.updatetime = 200            -- faster CursorHold events (used by LSP)
opt.timeoutlen = 300            -- key sequence timeout (ms)

-- Clipboard: sync with macOS clipboard
opt.clipboard = "unnamedplus"

-- Shell
opt.shell = "zsh"
