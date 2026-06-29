return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		ft = { "markdown" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint-cli2" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
				pattern = "*.md",
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
