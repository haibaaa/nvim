return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" }, -- defer until a file is opened
	build = ":TSUpdate", -- optional: auto-update parsers on plugin update
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript", "typescript", "c", "lua",
				"vim", "vimdoc", "query", "markdown", "markdown_inline",
			},

			sync_install = false,
			auto_install = false, -- ❌ turn this off to silence startup logs

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end
}

