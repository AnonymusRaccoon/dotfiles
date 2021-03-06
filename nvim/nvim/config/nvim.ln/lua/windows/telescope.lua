local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require "telescope.actions"
local transform_mod = require('telescope.actions.mt').transform_mod
local local_actions = transform_mod({
	commit = function()
		vim.cmd(":Git commit")
	end,
})

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			}
		},
		path_display = { "truncate" },
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-h>"] = function () vim.api.nvim_input("<C-w>") end,
				["<C-BS>"]  = function () vim.api.nvim_input("<C-w>") end,
				["<A-k>"] = actions.move_selection_previous,
				["<A-j>"] = actions.move_selection_next,
				["<c-t>"] = require "trouble.providers.telescope".open_with_trouble
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
		}
	},
	pickers = {
		find_files = {
			hidden = true,
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "-E", ".git" },
		},
		git_status = {
			mappings = {
				i = {
					["<c-c>"] = local_actions.commit,
				},
			},
		},
	},
})

telescope.load_extension('fzf')

local wk = require("which-key")
wk.register({
	f = { "<cmd>Telescope find_files<cr>", "Find files", },
	F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	g = {
		name = "Git",
		s = { "<cmd>Telescope git_status<cr>", "Git status" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	},
}, {
	prefix = "<leader>",
})
