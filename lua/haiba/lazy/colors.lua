local function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
	vim.cmd([[
		highlight! link TelescopeNormal         NormalFloat
		highlight! link TelescopeBorder         FloatBorder
		highlight! link TelescopePromptNormal   NormalFloat
		highlight! link TelescopeResultsNormal  NormalFloat
	]])
	vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Then return the plugin spec
return {
	-- {
	-- 	"vague2k/vague.nvim",
	-- 	config = function()
	-- 		require("vague").setup({
	-- 			-- optional configuration here
	-- 			transparent = true
	-- 		})
	-- 		ColorMyPencils("vague")
	-- 	end
	-- },
	{
	 	"rose-pine/neovim",
	 	name = "rose-pine",
	 	config = function()
	 		require("rose-pine").setup({
	 			disable_background = true,
	 			disable_float_background = true,
	 		})
	 		ColorMyPencils()
		end,
	},
}

