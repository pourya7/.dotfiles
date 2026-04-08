-- Autocmds
-- LazyVim sets sensible defaults; add extras here.

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup", "help", "lspinfo", "man",
    "notify", "qf", "spectre_panel", "startuptime",
    "tsplayground", "neotest-output", "checkhealth",
    "neotest-summary", "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Auto-set filetype for common web files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("web_filetypes"),
  pattern = { "*.env", "*.env.*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Strip trailing whitespace on save (except markdown)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("strip_trailing_ws"),
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})
