local M = {}
M.setup = function()
	local status_ok, cc = pcall(require, "virt-column")
	if not status_ok then
		return
	end
	cc.setup_buffer({ virtcolumn = "80,120", char = "▏" })
end

vim.cmd [[
	augroup virtcolumn
		autocmd!
		autocmd FileType * if index(["netrw", "NvimTree", "neo-tree", "UltestAttach", "dap-float", "Trouble", "lspinfo", "qf", "harpoon", "toggleterm", "packer"], &ft) == -1 | lua require("windows.colorcolumn").setup()
	augroup end
]]

return M

