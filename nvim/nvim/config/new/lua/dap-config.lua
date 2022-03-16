local ok, dap = pcall(require, "dap")
if not ok then
	return
end

dap.adapters = {
	coreclr = {
		type = 'executable',
		command = '/usr/bin/netcoredbg',
		args = {'--interpreter=vscode'}
	},
}

dap.configurations = {
	cs = {
		{
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				return "/home/anonymus-raccoon/projects/Kyoo/src/Kyoo.Host.Console/bin/Debug/net6.0/Kyoo.Host.Console.dll"
				-- return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
			end,
		},
	},
}

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = true,
	show_stop_reason = true,
})

local wk = require("which-key")
wk.register({
	d = {
		name = "Debugger",
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		b = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')<cr>", "Conditional Breakpoint" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "REPL" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		n = { "<cmd>lua require'dap'.step_over()<cr>", "Next" },
		s = { "<cmd>lua require'dap'.step_into()<cr>", "Step" },
		o = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	},
}, {
	prefix = "<leader>"
})
