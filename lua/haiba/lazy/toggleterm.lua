return {
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = function()
            require("toggleterm").setup({
                direction = "float",
                open_mapping = [[<c-\>]],
                float_opts = {
                    border = "curved",
                },
                on_open = function(term)
                    local cwd = vim.fn.expand("%:p:h")
                    if vim.fn.isdirectory(cwd) == 1 then
                        term:send("cd " .. cwd .. "\n", false)
                    end
                end,
            })
        end,
    },
}
