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

    local cap = client.resolved_capabilities
    if cap ~= nil and cap.document_highlight then
        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })
        vim.api.nvim_create_autocmd('CursorHoldI', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end

end)

lsp_zero.setup()
