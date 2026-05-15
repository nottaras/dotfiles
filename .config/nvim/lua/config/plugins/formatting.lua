return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
			},
			format_on_save = { timeout_ms = 500 },
		},
	},
}
