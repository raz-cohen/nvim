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
end)

lsp_zero.setup()
