-- Keymaps — loaded after plugins
-- LazyVim sets many sane defaults; this file adds personal overrides.

local map = vim.keymap.set

-- Better escape
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })
map("i", "kj", "<Esc>", { desc = "Escape insert mode" })

-- Save with Ctrl-s in any mode
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

-- Move between windows with Ctrl-hjkl (tmux-navigator compatible)
-- (LazyVim already maps these, but reinforced here)

-- Quick vertical split + open terminal
map("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" })

-- Resize panes with arrow keys
map("n", "<C-Up>",    "<cmd>resize +2<CR>")
map("n", "<C-Down>",  "<cmd>resize -2<CR>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")

-- Move lines in visual mode (like VSCode Alt+j/k)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Don't yank on paste in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlights
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Clear search highlights" })

-- Better indenting in visual mode (stay in visual)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Quickfix list navigation
map("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "<leader>qp", "<cmd>cprev<CR>", { desc = "Prev quickfix" })
