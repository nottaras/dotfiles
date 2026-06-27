return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "node_modules", ".git/" },
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					width = 0.8,
					height = 0.8,
				},
			},
		})
	end,
}
