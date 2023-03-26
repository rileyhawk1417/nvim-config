return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = "BufReadPost",

		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"astro",
				"bash",
				"c",
				"cpp",
				"html",
				"javascript",
				"json",
				"lua",
				"python",
				"rust",
				"typescript",
				"vim",
				"yaml",
				"markdown",
				"markdown_inline",
				"help",
				"tsx",
			},
			sync_install = false,
		},

		config = function(plugin, opts)
			if plugin.ensure_installed then
				require("util").deprecate("treesitter.ensure_installed", "treesitter.opts.ensure_installed")
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter",
	},
}
