-- GitHub Copilot — inline ghost-text completions
-- Uses copilot.lua (pure Lua, no dependency on LazyVim extras)
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false }, -- ghost text only, no panel
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true, -- hide when nvim-cmp menu is open
        keymap = {
          accept      = "<M-l>",     -- Alt+l: accept full suggestion
          accept_word = "<M-Right>", -- Alt+Right: accept one word
          next        = "<M-]>",     -- Alt+]: next suggestion
          prev        = "<M-[>",     -- Alt+[: previous suggestion
          dismiss     = "<M-e>",     -- Alt+e: dismiss
        },
      },
      filetypes = {
        gitcommit = true,
        markdown  = true,
        help      = false,
      },
    },
  },
}
