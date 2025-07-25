return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
}
