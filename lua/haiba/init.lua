vim.lsp.log_level = "debug"

-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Automatically change cwd to the directory of the current file
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
        local path = vim.fn.expand("%:p:h")
        if vim.fn.isdirectory(path) == 1 then
            vim.cmd("cd " .. path)
        end
    end,
    desc = "Auto-CD to current file's directory",
})


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

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     callback = function()
--         vim.lsp.buf.format({ async = false })
--     end,
-- })

-- Global indentation settings
vim.opt.tabstop = 4      -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4   -- Number of spaces for autoindent
vim.opt.softtabstop = 4  -- Number of spaces for a tab in insert mode
vim.opt.expandtab = true -- Convert tabs to spaces

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

require("haiba.remap")
require("haiba.lazy_init")
