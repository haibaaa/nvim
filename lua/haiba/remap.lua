-- Set leader before using it in mappings
vim.g.mapleader = " "

-- Map <leader>pv to open netrw (Ex command)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
