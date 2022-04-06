local options = {
	fileencoding = "utf-8",
	expandtab = false,
	shiftwidth = 4,
	tabstop = 4,
	cinoptions = {
		"(1s"
	},

	hlsearch = true,
	ignorecase = true,
	smartcase = true,

	mouse = "a",
	splitbelow = true,
	splitright = true,
	cursorline = true,
	sidescrolloff = 8,
	wrap = false,

	termguicolors = true,
	swapfile = false,
	undofile = true,
	updatetime = 300,                        -- faster completion (4000ms default)

	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",

	list = true,
	listchars = {
		space = "·",
		tab = "▷ ",
		extends = "◣",
		precedes = "◢",
		nbsp = "○",
	},
	fillchars = {
		diff = "╱",
	},
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move in insert mode --
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-l>", "<Right>", opts)

keymap("i", "<C-BS>", "<C-w>", opts)
keymap("c", "<C-BS>", "<C-w>", opts)
keymap("i", "<C-H>", "<C-w>", opts) -- Keymap for CTRL-BACKSPACE on some termial emulators.
keymap("c", "<C-H>", "<C-w>", opts)

keymap("n", "<leader>y", '"+y', opts)
keymap("x", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)
keymap("x", "<leader>Y", '"+Y', opts)

keymap("t", "<C-W>", "<C-\\><C-N><C-W>", opts)

vim.cmd [[
	augroup highlight_yank
		autocmd!
		autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
	augroup end
]]

