return {}
--[[
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			sync_root_with_cwd = true,
			update_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			view = {
				width = 25,
				side = "left",
			},
		})
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
	end,
}
]]--

