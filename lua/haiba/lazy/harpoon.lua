return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- required
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
            }
        })

        -- ui config for toggle_quick_menu
        local toggle_opts = {
            title = " harpoon ",
            border = "rounded",
            title_pos = "left",
        }

        -- keybindings
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end, { desc = "harpoon: toggle quick menu" })

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "harpoon: add current file" })

        -- ctrl-based quick access
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "harpoon: go to file 1" })
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "harpoon: go to file 2" })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "harpoon: go to file 3" })
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "harpoon: go to file 4" })
    end,
}
