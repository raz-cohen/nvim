local lsp_zero = require("lsp-zero")
local mason = require("mason")
local masonLSP = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup({})
masonLSP.setup({
    ensure_installed = {
        'eslint',
        'lua_ls',
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end
    }
})

lspconfig.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    "${3rd}/luv/library",
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}


lsp_zero.preset("recommended")

lsp_zero.set_preferences({
    sign_icons = {}
})


lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false
    })

    if client.server_capabilities.documentHighlightProvider then
        local highlight_references = function()
            vim.lsp.buf.document_highlight()
        end

        local clear_references = function()
            vim.lsp.buf.clear_references()
        end

        local function setup_autocmds()
            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = bufnr,
                callback = function()
                    highlight_references()
                end,
                desc = 'LSP Document Highlight on CursorMoved'
            })
            vim.api.nvim_create_autocmd('CursorMovedI', {
                buffer = bufnr,
                callback = function()
                    highlight_references()
                end,
                desc = 'LSP Document Highlight on CursorMovedI'
            })
            vim.api.nvim_create_autocmd('InsertLeave', {
                buffer = bufnr,
                callback = function()
                    clear_references()
                end,
                desc = 'LSP Clear References on InsertLeave'
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = bufnr,
                callback = function()
                    clear_references()
                end,
                desc = 'LSP Clear References on CursorMoved'
            })
            vim.api.nvim_create_autocmd('CursorMovedI', {
                buffer = bufnr,
                callback = function()
                    clear_references()
                end,
                desc = 'LSP Clear References on CursorMovedI'
            })
        end

        setup_autocmds()
    end
end)

lsp_zero.setup()

vim.keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end , { noremap = true, desc = "LSP Code Action" })


