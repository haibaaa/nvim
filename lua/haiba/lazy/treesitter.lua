return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" }, -- defer until a file is opened
    build = ":TSUpdate",                     -- optional: auto-update parsers on plugin update
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "go", "zig", "javascript", "typescript", "c", "lua",
                "vim", "vimdoc", "query", "markdown", "markdown_inline",
                -- Consider removing languages you don't frequently use
                -- For example, if you rarely touch Zig, remove "zig"
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            -- ADD THESE LINES TO CONTROL VERBOSITY AND INSTALLATION BEHAVIOR:
            sync_install = false, -- Install parsers asynchronously (recommended)
            log_level = "warn",   -- Set to "warn" or "error" for less output

            -- Optional: configure specific parser install settings if needed
            -- install = {
            --     -- You could set specific logging levels for installation if desired
            --     -- but `log_level` above should cover it for overall operation
            --     -- You can also control the 'auto_install' behavior
            --     -- auto_install = true, -- Default is true, meaning it tries to install missing parsers
            -- },

            -- Add other configurations like `indent` if you need it:
            -- indent = {
            --   enable = true,
            -- },
        })
    end
}
