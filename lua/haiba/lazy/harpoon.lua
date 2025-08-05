return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- Setup with global list configuration
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
                -- Use a static key instead of cwd-based key
                key = function()
                    return "global"
                end,
            },
            -- Custom list configuration for cross-directory support
            default = {
                create_list_item = function(config, item)
                    if item == nil then
                        item = vim.api.nvim_buf_get_name(
                            vim.api.nvim_get_current_buf()
                        )
                    end

                    if type(item) == "string" then
                        local name = require("plenary.path"):new(item):absolute()
                        local bufnr = vim.fn.bufnr(name, false)

                        local pos = { 1, 0 }
                        if bufnr ~= -1 then
                            pos = vim.api.nvim_win_get_cursor(0)
                        end

                        item = {
                            value = name,
                            context = {
                                row = pos[1],
                                col = pos[2],
                            },
                        }
                    end
                    return item
                end,
            }
        })

        -- UI config for toggle_quick_menu
        local toggle_opts = {
            title = " harpoon ",
            border = "rounded",
            title_pos = "left",
        }

        -- Keybindings
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end, { desc = "harpoon: toggle quick menu" })

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "harpoon: add current file" })

        -- Ctrl-based quick access
        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end, { desc = "harpoon: go to file 1" })

        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(2)
        end, { desc = "harpoon: go to file 2" })

        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():select(3)
        end, { desc = "harpoon: go to file 3" })

        vim.keymap.set("n", "<C-s>", function()
            harpoon:list():select(4)
        end, { desc = "harpoon: go to file 4" })
    end,
}
