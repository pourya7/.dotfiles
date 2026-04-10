-- UI tweaks on top of LazyVim defaults
return {
	-- Dashboard with a nice header
	{
		"folke/snacks.nvim",
		optional = true,
		opts = {
			dashboard = {
				preset = {
					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				},
			},
			picker = {
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
					},
					files = {
						hidden = true,
						ignored = true,
					},
				},
			},
		},
	},

	-- Lualine: merge into LazyVim's existing setup rather than replacing it
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		opts = function(_, opts)
			-- LazyVim already wires catppuccin; just ensure globalstatus is on
			opts.options = opts.options or {}
			opts.options.globalstatus = true
		end,
	},

	-- Noice: richer command-line and notifications
	{
		"folke/noice.nvim",
		optional = true,
		opts = {
			presets = {
				lsp_doc_border = true, -- border around hover/signature docs
			},
		},
	},
}
