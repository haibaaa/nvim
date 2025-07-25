return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            format_on_save = function(bufnr)
                -- Disable autoformat for files in /tmp
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match("^/tmp/") then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                lua = { "stylua" },
                markdown = { "cbfmt", "markdownlint" },
                -- add other filetypes here
            },
            formatters = {
                clang_format = {
                    prepend_args = {
                        "--style={BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4, UseTab: Never, IndentCaseLabels: true}"
                    },
                },
            },

        })

        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end, { desc = "Format file" })
    end,
}
