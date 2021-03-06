local Job = require 'plenary.job'

local M = {}

M.patterns = { "*.sln" }

M.list = function()
	local ignore = 3
	local ret = {}

	Job:new({
		command = "dotnet",
		args = { "sln", "list" },
		on_stdout = function(_, proj)
			if ignore > 0 then
				ignore = ignore - 1
				return
			end
			table.insert(ret, {
				name = proj:match("([^/]+).csproj$"),
				file = proj,
				icon = "",
			})
		end,
	}):sync()
	return ret
end

M.build = function(proj)
	local function add_to_qf(err, data)
		vim.fn.setqflist({}, "a", {
			efm = [[%f(%l\,%c): %t%*[^ ] %m]],
			lines = { err and err or data },
		})
	end

	return Job:new({
		command = "dotnet",
		args = { "build", proj.file },
		on_stdout = vim.schedule_wrap(add_to_qf),
		on_stderr = vim.schedule_wrap(add_to_qf),
	})
end


M.run = function(proj)
	return "dotnet run --project " .. proj.file
end

M.require_build = false

return M
