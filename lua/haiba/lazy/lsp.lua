-- ~/.config/nvim/lua/your_config_folder/lsp.lua
-- This file defines your Language Server Protocol (LSP) configuration.

-- Set LSP log level to debug. Note: This might be overridden by very early
-- Neovim settings or environment variables, as we observed in debugging.
-- For guaranteed debug logs, launch Neovim with:
-- NVIM_LOG_FILE="/tmp/nvim_lsp.log" NVIM_LOG_LEVEL="debug" nvim
-- vim.lsp.log_level = "debug"

-- Define a reusable on_attach function
-- This function runs every time an LSP client successfully attaches to a buffer.
local on_attach = function(client, bufnr)
    -- Set buffer-local keymaps for LSP functionalities
    -- These keymaps will only be active when an LSP client is attached to the specific buffer.
    local opts = { buffer = bufnr, silent = true }

    -- General LSP Keymaps (using common Neovim conventions)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)          -- Go to definition
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)         -- Go to declaration
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)          -- Find references
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                -- Show hover documentation
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename symbol
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code action
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)   -- Show function signature help (in insert mode)

    -- Diagnostic Keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)          -- Go to previous diagnostic
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)          -- Go to next diagnostic
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts) -- Open diagnostic in a float window

    -- Enable completion (Omni-completion for Neovim's built-in, or for nvim-cmp if you use it)
    if client.supports_method "textDocument/completion" then
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.buf.omnifunc')
    end

    -- Optional: Auto-formatting on save (uncomment if desired)
    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = vim.api.nvim_create_augroup("LspFormatting." .. bufnr, { clear = true }),
    --         buffer = bufnr,
    --         callback = function()
    --             vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1500 })
    --         end,
    --     })
    -- end
end

-- This table will be returned by the file and processed by Lazy.nvim
return {
    -- The main nvim-lspconfig plugin
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",           -- LSP server installer
        "williamboman/mason-lspconfig.nvim", -- Bridges mason and lspconfig
    },
    config = function()
        -- 1. Setup Mason (the LSP server installer)
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })


        -- 2. Setup Mason-LSPconfig
        -- This ensures the specified servers are installed by Mason.
        -- We are explicitly listing all servers here for clarity and management.
        -- We will NOT use its generic 'handlers' here, as direct lspconfig.setup is more reliable for your setup.
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",        -- Lua language server
                "ts_ls",         -- TypeScript/JavaScript language server (now officially 'ts_ls')
                "rust_analyzer", -- Rust language server
                "gopls",         -- Go language server
                "clangd",        -- C/C++/Objective-C language server
                "zls",           -- Zig language server
                "svelte",        -- Svelte language server
                "marksman",      -- Markdown language server
                "html",          -- HTML language server
                "cssls",         -- CSS language server
                -- Add any other language servers you frequently use here
                -- "pyright", "jsonls", "html", "cssls", "marksman", etc.
            },
            -- Handlers block remains commented out, all setup will be direct.
            -- handlers = { ... }
        })


        -- 3. Direct LSP Configuration for each server
        -- This provides fine-grained control for each language server.

        -- Lua Language Server (lua_ls)
        require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = vim.split(package.path, ';'),
                    },
                    diagnostics = {
                        globals = { 'vim', 'require', 'use', 'M' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.fn.stdpath('config') .. '/lua',
                            vim.fn.stdpath('data') .. '/lazy',
                        },
                    },
                    telemetry = { enable = false },
                },
            },
        })

        -- Go Language Server (gopls)
        require("lspconfig").gopls.setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern("go.mod", ".git", ".go"),
            settings = {
                -- Gopls specific settings go DIRECTLY here
                -- Example settings:
                -- buildFlags = { "-tags=wiremock" },
                -- experimental = { allowImplicitNetwork = true },
                -- staticcheck = true,
                -- vulns = true,
            },
        })

        -- TypeScript/JavaScript Language Server (ts_ls)
        require("lspconfig").ts_ls.setup({ -- Changed from tsserver to ts_ls
            on_attach = on_attach,
            settings = {},
        })

        -- Rust Analyzer (rust_analyzer)
        require("lspconfig").rust_analyzer.setup({
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                }
            }
        })

        -- Clangd (C/C++/Objective-C Language Server)
        require("lspconfig").clangd.setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern(
                ".clangd", "compile_commands.json", "compile_flags.txt", ".git"
            ),
            settings = {},
        })

        -- Zig Language Server (zls)
        require("lspconfig").zls.setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern("build.zig", "zls.json", ".git"),
            settings = {},
        })

        -- Svelte Language Server (svelte)
        require("lspconfig").svelte.setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern("svelte.config.js", "package.json", ".git"),
            settings = {
                svelte = {
                    plugin = {
                        svelte = {
                            format = {
                                enable = true,
                            },
                        },
                    },
                },
            },
        })

        -- Marksman (Markdown Language Server)
        require("lspconfig").marksman.setup({
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml"),
        })

        -- HTML Language Server
        require("lspconfig").html.setup({
            on_attach = on_attach,
            settings = {
                html = {
                    format = {
                        enable = true,
                    },
                },
            },
        })

        -- CSS Language Server
        require("lspconfig").cssls.setup({
            on_attach = on_attach,
            settings = {
                css = {
                    validate = true,
                },
                scss = {
                    validate = true,
                },
                less = {
                    validate = true,
                },
            },
        })
    end,
}
