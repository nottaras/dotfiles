return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				"lua",
				"markdown",
				"markdown_inline",
				"bash",
				"json",
				"yaml",
				"toml",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
