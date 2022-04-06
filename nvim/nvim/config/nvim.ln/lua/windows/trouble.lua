local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup({
	auto_close = false,
})

local wk = require("which-key")
wk.register({
	l = {
		d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
		t = { "<cmd>TroubleToggle<CR>", "Toogle trouble window" },
	},
}, {
	prefix = "<leader>",
})

local tc_ok, tc = pcall(require, "todo-comments")
if not tc_ok then
	return
end

tc.setup({ })
