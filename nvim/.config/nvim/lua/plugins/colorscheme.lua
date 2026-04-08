-- Colorscheme: Catppuccin Mocha
return {
  -- Set Catppuccin as the colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = false,  -- we use neo-tree (LazyVim default)
        neo_tree = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        mason = true,
        mini = { enabled = true, indentscope_color = "" },
        lsp_trouble = true,
        which_key = true,
        illuminate = { enabled = true },
        indent_blankline = { enabled = true },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = { background = true },
        },
      },
    },
  },

  -- Tell LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
