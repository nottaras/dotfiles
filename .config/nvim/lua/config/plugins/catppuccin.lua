return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local function get_flavour()
			local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
			return result:find("Dark") and "mocha" or "latte"
		end

		require("catppuccin").setup({
			flavour = get_flavour(),
			integrations = {
				telescope = true,
				neo_tree = true,
				treesitter = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")

		vim.api.nvim_create_autocmd("FocusGained", {
			callback = function()
				require("catppuccin").setup({ flavour = get_flavour() })
				vim.cmd.colorscheme("catppuccin")
			end,
		})
	end,
}
