local lsp_zero = require("lsp-zero")
local mason = require("mason")
local masonLSP = require("mason-lspconfig")

mason.setup({})
masonLSP.setup({
	ensure_installed = {
		'tsserver',
		'eslint',
	},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end
	}
})


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
