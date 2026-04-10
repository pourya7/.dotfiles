-- Language tweaks (custom overrides only)
-- LazyVim extras are declared in lua/config/lazy.lua in the correct spec order.
return {
  -- Ensure conform.nvim uses prettier for JS/TS when a config file is present
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        css             = { "prettier" },
        html            = { "prettier" },
        json            = { "prettier" },
        yaml            = { "prettier" },
        -- markdown        = { "prettier" },
      },
    },
  },

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.markdown = {}
		end,
	},

  -- Python: prefer ruff over pyright for formatting/linting speed
  {
    "nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = { typeCheckingMode = "basic" },
            },
          },
        },
      },
    },
  },
}
