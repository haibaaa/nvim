-- Safe notify override for fast event context errors
if not vim._safe_notify_patched then
	local orig_notify = vim.notify
	vim.notify = function(msg, level, opts)
		local function safe()
			orig_notify(msg, level, opts)
		end

		local ok = pcall(vim.schedule, safe)
		if not ok then
			-- fallback: write to message area
			vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
		end
	end
	vim._safe_notify_patched = true
end


require("haiba.remap")
require("haiba.lazy_init")
