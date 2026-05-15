local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.fileencoding = "utf-8"
vim.opt.swapfile = false
vim.opt.backup = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	{
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
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = { width = 30 },
				filesystem = {
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
				},
			})
		end,
	},

	{
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
	},

	{
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
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = "|",
					section_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1, modified_status = true } },
					lualine_z = { "location" },
				},
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = true,
	},

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
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

  {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "-" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
  },
},

{
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "LazyGit",
},

{
  "akinsho/toggleterm.nvim",
  keys = "<leader>tt",
  opts = {
    open_mapping = "<leader>tt",
    direction = "float",
    float_opts = { border = "curved" },
  },
},
})

local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

map("n", "<leader>e", "<cmd>Neotree toggle<CR>", "Toggle file explorer")
map("n", "<leader>o", "<cmd>Neotree focus<CR>", "Focus file explorer")

map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", "Find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", "Search in files (grep)")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", "List open buffers")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", "Recent files")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", "Search help")

map("n", "<C-h>", "<C-w>h", "Move to left window")
map("n", "<C-j>", "<C-w>j", "Move to window below")
map("n", "<C-k>", "<C-w>k", "Move to window above")
map("n", "<C-l>", "<C-w>l", "Move to right window")

map("n", "<C-Up>", "<cmd>resize +2<CR>", "Increase height")
map("n", "<C-Down>", "<cmd>resize -2<CR>", "Decrease height")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", "Decrease width")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Increase width")

map("n", "<S-l>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<S-h>", "<cmd>bprevious<CR>", "Previous buffer")
map("n", "<leader>bd", "<cmd>bdelete<CR>", "Close buffer")

map("n", "<leader>w", "<cmd>set wrap!<CR>", "Toggle line wrap")

map("n", "<leader>s", "<cmd>w<CR>", "Save file")
map("n", "<C-s>", "<cmd>w<CR>", "Save file")

map("v", "<", "<gv", "Indent left (stay in visual)")
map("v", ">", ">gv", "Indent right (stay in visual)")

map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")

map("n", "<C-d>", "<C-d>zz", "Scroll down (centred)")
map("n", "<C-u>", "<C-u>zz", "Scroll up (centred)")

map("n", "n", "nzzzv", "Next search result (centred)")
map("n", "N", "Nzzzv", "Prev search result (centred)")

map("n", "<leader>gg", "<cmd>LazyGit<CR>",                           "Open LazyGit")
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>",               "Blame line")
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>",                 "Diff file")
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>",               "Stage hunk")
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>",               "Reset hunk")
map("n", "]h",         "<cmd>Gitsigns next_hunk<CR>",                "Next hunk")
map("n", "[h",         "<cmd>Gitsigns prev_hunk<CR>",                "Prev hunk")
