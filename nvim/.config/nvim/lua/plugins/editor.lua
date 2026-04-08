-- Editor experience plugins
return {
  -- Don't auto-open neo-tree when nvim is launched with a directory argument.
  -- LazyVim's default init does this; override it with an empty function.
  -- Toggle the explorer manually with <leader>e or <leader>E.
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function() end,
  },

  -- tmux + neovim seamless navigation (Ctrl-hjkl across both)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp", "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    },
  },

  -- Harpoon v2: quick file marks (great for jumping between 3-4 files)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>ha",
        function() require("harpoon"):list():add() end,
        desc = "Harpoon: add file",
      },
      {
        "<leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon: toggle menu",
      },
      {
        "<leader>h1",
        function() require("harpoon"):list():select(1) end,
        desc = "Harpoon: file 1",
      },
      {
        "<leader>h2",
        function() require("harpoon"):list():select(2) end,
        desc = "Harpoon: file 2",
      },
      {
        "<leader>h3",
        function() require("harpoon"):list():select(3) end,
        desc = "Harpoon: file 3",
      },
      {
        "<leader>h4",
        function() require("harpoon"):list():select(4) end,
        desc = "Harpoon: file 4",
      },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- Better diagnostics view
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- Surround text objects (ys, cs, ds)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- Git diff in the gutter + inline blame
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
    },
  },

  -- Highlight TODO/FIXME/HACK/NOTE comments
  {
    "folke/todo-comments.nvim",
    opts = { signs = false },
  },
}
