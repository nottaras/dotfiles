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
