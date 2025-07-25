return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "lsp", "pattern" },          -- tries LSP root first, then patterns
            patterns = { ".git", "Makefile", "package.json" }, -- what marks a root
            silent_chdir = false,                              -- prints cwd change (you can make this true later)
            scope_chdir = 'global',                            -- or 'tab' or 'win'
        })

        -- Optionally integrate with telescope
        require("telescope").load_extension("projects")
    end,
}
